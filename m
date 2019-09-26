Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37BFBF6AE
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfIZQ3E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Sep 2019 12:29:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQ3D (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Sep 2019 12:29:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E80F028;
        Thu, 26 Sep 2019 09:29:02 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926123F534;
        Thu, 26 Sep 2019 09:29:01 -0700 (PDT)
Date:   Thu, 26 Sep 2019 17:28:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 4/4] PCI: hv: Change pci_protocol_version to per-hbus
Message-ID: <20190926162856.GA7827@e121166-lin.cambridge.arm.com>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
 <1568245086-70601-5-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568245086-70601-5-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 11, 2019 at 11:38:23PM +0000, Dexuan Cui wrote:
> A VM can have multiple hbus. It looks incorrect for the second hbus's
> hv_pci_protocol_negotiation() to set the global variable
> 'pci_protocol_version' (which was set by the first hbus), even if the
> same value is written.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

This is a fix that seems unrelated to the rest of the series.

AFAICS the version also affects code paths in the driver, which
means that in case you have busses with different versions the
current code is wrong in this respect.

You have to capture this concept in the commit log, it reads as
an optional change but it looks like a potential bug.

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 2655df2..55730c5 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -76,11 +76,6 @@ enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_1,
>  };
>  
> -/*
> - * Protocol version negotiated by hv_pci_protocol_negotiation().
> - */
> -static enum pci_protocol_version_t pci_protocol_version;
> -
>  #define PCI_CONFIG_MMIO_LENGTH	0x2000
>  #define CFG_PAGE_OFFSET 0x1000
>  #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
> @@ -429,6 +424,8 @@ enum hv_pcibus_state {
>  
>  struct hv_pcibus_device {
>  	struct pci_sysdata sysdata;
> +	/* Protocol version negotiated with the host */
> +	enum pci_protocol_version_t protocol_version;
>  	enum hv_pcibus_state state;
>  	refcount_t remove_lock;
>  	struct hv_device *hdev;
> @@ -942,7 +939,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  	 * negative effect (yet?).
>  	 */
>  
> -	if (pci_protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
> +	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
>  		/*
>  		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
>  		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
> @@ -1112,7 +1109,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
>  	ctxt.pci_pkt.compl_ctxt = &comp;
>  
> -	switch (pci_protocol_version) {
> +	switch (hbus->protocol_version) {
>  	case PCI_PROTOCOL_VERSION_1_1:
>  		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
>  					dest,
> @@ -2116,6 +2113,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
>  				       enum pci_protocol_version_t version[],
>  				       int num_version)
>  {
> +	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
>  	struct pci_version_request *version_req;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> @@ -2155,10 +2153,10 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
>  		}
>  
>  		if (comp_pkt.completion_status >= 0) {
> -			pci_protocol_version = version[i];
> +			hbus->protocol_version = version[i];
>  			dev_info(&hdev->device,
>  				"PCI VMBus probing: Using version %#x\n",
> -				pci_protocol_version);
> +				hbus->protocol_version);
>  			goto exit;
>  		}
>  
> @@ -2442,7 +2440,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  	u32 wslot;
>  	int ret;
>  
> -	size_res = (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2)
> +	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
>  			? sizeof(*res_assigned) : sizeof(*res_assigned2);
>  
>  	pkt = kmalloc(sizeof(*pkt) + size_res, GFP_KERNEL);
> @@ -2461,7 +2459,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  		pkt->completion_func = hv_pci_generic_compl;
>  		pkt->compl_ctxt = &comp_pkt;
>  
> -		if (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2) {
> +		if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2) {
>  			res_assigned =
>  				(struct pci_resources_assigned *)&pkt->message;
>  			res_assigned->message_type.type =
> @@ -2812,7 +2810,7 @@ static int hv_pci_resume(struct hv_device *hdev)
>  		return ret;
>  
>  	/* Only use the version that was in use before hibernation. */
> -	version[0] = pci_protocol_version;
> +	version[0] = hbus->protocol_version;
>  	ret = hv_pci_protocol_negotiation(hdev, version, 1);
>  	if (ret)
>  		goto out;
> -- 
> 1.8.3.1
> 
