Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B551E12CE
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2020 18:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgEYQi1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 May 2020 12:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEYQi0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 May 2020 12:38:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2962070A;
        Mon, 25 May 2020 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590424706;
        bh=tyXYVbZ/KHxp0iFJ0teaN0huGpPC0vGPMko7EezkrzA=;
        h=Date:From:To:Cc:Subject:From;
        b=T5N6Hm3fxSQ5UoU82qWAI8fyzyz3qLy2aRJsMML8xP/fjw/9NH2FS6WgCyA+itScw
         HphVELVjW+M0hBu75OhUstD59nBKTjTujkMIHqjnLROltItOJ5tW+d5Nl6RcM2MF9L
         ns+FcR3ZgCwGQHbXYRRIPva1kJYhiv/JioPTow/s=
Date:   Mon, 25 May 2020 11:43:19 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] PCI: hv: Use struct_size() helper
Message-ID: <20200525164319.GA13596@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct hv_dr_state {
	...
        struct hv_pcidev_description func[];
};

struct pci_bus_relations {
	...
        struct pci_function_description func[];
} __packed;

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following forms:

offsetof(struct hv_dr_state, func) +
	(sizeof(struct hv_pcidev_description) *
	(relations->device_count))

offsetof(struct pci_bus_relations, func) +
	(sizeof(struct pci_function_description) *
	(bus_rel->device_count))

with:

struct_size(dr, func, relations->device_count)

and

struct_size(bus_rel, func, bus_rel->device_count)

respectively.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 892f3a742117a..bf40ff09c99d6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2213,10 +2213,8 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	struct hv_dr_state *dr;
 	int i;
 
-	dr = kzalloc(offsetof(struct hv_dr_state, func) +
-		     (sizeof(struct hv_pcidev_description) *
-		      (relations->device_count)), GFP_NOWAIT);
-
+	dr = kzalloc(struct_size(dr, func, relations->device_count),
+		     GFP_NOWAIT);
 	if (!dr)
 		return;
 
@@ -2250,10 +2248,8 @@ static void hv_pci_devices_present2(struct hv_pcibus_device *hbus,
 	struct hv_dr_state *dr;
 	int i;
 
-	dr = kzalloc(offsetof(struct hv_dr_state, func) +
-		     (sizeof(struct hv_pcidev_description) *
-		      (relations->device_count)), GFP_NOWAIT);
-
+	dr = kzalloc(struct_size(dr, func, relations->device_count),
+		     GFP_NOWAIT);
 	if (!dr)
 		return;
 
@@ -2447,9 +2443,8 @@ static void hv_pci_onchannelcallback(void *context)
 
 				bus_rel = (struct pci_bus_relations *)buffer;
 				if (bytes_recvd <
-				    offsetof(struct pci_bus_relations, func) +
-				    (sizeof(struct pci_function_description) *
-				     (bus_rel->device_count))) {
+					struct_size(bus_rel, func,
+						    bus_rel->device_count)) {
 					dev_err(&hbus->hdev->device,
 						"bus relations too small\n");
 					break;
@@ -2462,9 +2457,8 @@ static void hv_pci_onchannelcallback(void *context)
 
 				bus_rel2 = (struct pci_bus_relations2 *)buffer;
 				if (bytes_recvd <
-				    offsetof(struct pci_bus_relations2, func) +
-				    (sizeof(struct pci_function_description2) *
-				     (bus_rel2->device_count))) {
+					struct_size(bus_rel2, func,
+						    bus_rel2->device_count)) {
 					dev_err(&hbus->hdev->device,
 						"bus relations v2 too small\n");
 					break;
-- 
2.26.2

