Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64B61E6432
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2020 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgE1OlN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 May 2020 10:41:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgE1OlM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 May 2020 10:41:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF3BD6E;
        Thu, 28 May 2020 07:41:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11383F52E;
        Thu, 28 May 2020 07:41:09 -0700 (PDT)
Date:   Thu, 28 May 2020 15:41:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PCI: hv: Use struct_size() helper
Message-ID: <20200528144107.GB28290@e121166-lin.cambridge.arm.com>
References: <20200525164319.GA13596@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525164319.GA13596@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 25, 2020 at 11:43:19AM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct hv_dr_state {
> 	...
>         struct hv_pcidev_description func[];
> };
> 
> struct pci_bus_relations {
> 	...
>         struct pci_function_description func[];
> } __packed;
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following forms:
> 
> offsetof(struct hv_dr_state, func) +
> 	(sizeof(struct hv_pcidev_description) *
> 	(relations->device_count))
> 
> offsetof(struct pci_bus_relations, func) +
> 	(sizeof(struct pci_function_description) *
> 	(bus_rel->device_count))
> 
> with:
> 
> struct_size(dr, func, relations->device_count)
> 
> and
> 
> struct_size(bus_rel, func, bus_rel->device_count)
> 
> respectively.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)

Applied to pci/hv, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 892f3a742117a..bf40ff09c99d6 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2213,10 +2213,8 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>  	struct hv_dr_state *dr;
>  	int i;
>  
> -	dr = kzalloc(offsetof(struct hv_dr_state, func) +
> -		     (sizeof(struct hv_pcidev_description) *
> -		      (relations->device_count)), GFP_NOWAIT);
> -
> +	dr = kzalloc(struct_size(dr, func, relations->device_count),
> +		     GFP_NOWAIT);
>  	if (!dr)
>  		return;
>  
> @@ -2250,10 +2248,8 @@ static void hv_pci_devices_present2(struct hv_pcibus_device *hbus,
>  	struct hv_dr_state *dr;
>  	int i;
>  
> -	dr = kzalloc(offsetof(struct hv_dr_state, func) +
> -		     (sizeof(struct hv_pcidev_description) *
> -		      (relations->device_count)), GFP_NOWAIT);
> -
> +	dr = kzalloc(struct_size(dr, func, relations->device_count),
> +		     GFP_NOWAIT);
>  	if (!dr)
>  		return;
>  
> @@ -2447,9 +2443,8 @@ static void hv_pci_onchannelcallback(void *context)
>  
>  				bus_rel = (struct pci_bus_relations *)buffer;
>  				if (bytes_recvd <
> -				    offsetof(struct pci_bus_relations, func) +
> -				    (sizeof(struct pci_function_description) *
> -				     (bus_rel->device_count))) {
> +					struct_size(bus_rel, func,
> +						    bus_rel->device_count)) {
>  					dev_err(&hbus->hdev->device,
>  						"bus relations too small\n");
>  					break;
> @@ -2462,9 +2457,8 @@ static void hv_pci_onchannelcallback(void *context)
>  
>  				bus_rel2 = (struct pci_bus_relations2 *)buffer;
>  				if (bytes_recvd <
> -				    offsetof(struct pci_bus_relations2, func) +
> -				    (sizeof(struct pci_function_description2) *
> -				     (bus_rel2->device_count))) {
> +					struct_size(bus_rel2, func,
> +						    bus_rel2->device_count)) {
>  					dev_err(&hbus->hdev->device,
>  						"bus relations v2 too small\n");
>  					break;
> -- 
> 2.26.2
> 
