/* SPDX-License-Identifier: MIT */
/*
 * Copyright (c) 2018-2021 Alex Forencich
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#ifndef EXAMPLE_DRIVER_H
#define EXAMPLE_DRIVER_H

#include <linux/kernel.h>

#define DRIVER_NAME "edev"
#define DRIVER_VERSION "0.1"

struct example_dev {
	struct pci_dev *pdev;
	struct device *dev;

	// BAR pointers
	void __iomem *bar[6];
	resource_size_t bar_len[6];

	// DMA buffer
	size_t dma_region_len;
	void *dma_region;
	dma_addr_t dma_region_addr;

	int irqcount;
};

#endif /* EXAMPLE_DRIVER_H */
