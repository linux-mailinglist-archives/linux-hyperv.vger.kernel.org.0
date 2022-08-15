Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1F594BF0
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 03:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbiHPAb5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 20:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353373AbiHPAbV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 20:31:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4B185995;
        Mon, 15 Aug 2022 13:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80BEFB80EA8;
        Mon, 15 Aug 2022 20:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3557C433D6;
        Mon, 15 Aug 2022 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660595747;
        bh=qf1uXQYDzbCjJhqp5PrXmCPOXnbpAKK9chCCYP5tWtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mo2MIfNF13xv6ntikuuQImFWHu1+thv5ivjIepIpCv0iYKXdmyrHjTCbOU+2XIS64
         f6WCphkw7c+m0SbEE7D3r+DF+z9qjO0Z1nvGWl9PdvGqEm1i0N2oQK1ofz4DBye0c6
         kj6LvC/Ml16VQRk1bWYc4eaz9vsohJtgqt+IC/MN5i82KcPba7lv5mwuk5dQ97Cz9j
         pnUDHukh7zG3YKYptmuge4JNm6/ZCGUHaRe6eHL8pU4irn2Lv+zXOCALjx8MWlMbkY
         rMzbII0WZ1fiQ8fNRhs1/1SFJF6mnieJxsQEaxZ75cCIu7tJvfsuhdhhelo2Dm5Thn
         e7w/Qj1M67ScA==
Date:   Mon, 15 Aug 2022 15:35:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     quic_jhugo@quicinc.com, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: Re: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Message-ID: <20220815203545.GA1971949@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815185505.7626-1-decui@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

s/definiton/definition/ in subject
(only if you have other occasion to repost this)

On Mon, Aug 15, 2022 at 11:55:05AM -0700, Dexuan Cui wrote:
> The local variable 'vector' must be u32 rather than u8: see the
> struct hv_msi_desc3.
> 
> 'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
> hv_msi_desc2 and hv_msi_desc3.
> 
> Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Cc: Carl Vanderlip <quic_carlv@quicinc.com>

Looks like Wei has been applying most changes to pci-hyperv.c, so I
assume the same will happen here.

> ---
> 
> The patch should be appplied after the earlier patch:
>     [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
>     https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui%40microsoft.com/
> 
>  drivers/pci/controller/pci-hyperv.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 65d0dab25deb..53580899c859 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1614,7 +1614,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
>  
>  static u32 hv_compose_msi_req_v1(
>  	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
> -	u32 slot, u8 vector, u8 vector_count)
> +	u32 slot, u8 vector, u16 vector_count)
>  {
>  	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
>  	int_pkt->wslot.slot = slot;
> @@ -1642,7 +1642,7 @@ static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
>  
>  static u32 hv_compose_msi_req_v2(
>  	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
> -	u32 slot, u8 vector, u8 vector_count)
> +	u32 slot, u8 vector, u16 vector_count)
>  {
>  	int cpu;
>  
> @@ -1661,7 +1661,7 @@ static u32 hv_compose_msi_req_v2(
>  
>  static u32 hv_compose_msi_req_v3(
>  	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
> -	u32 slot, u32 vector, u8 vector_count)
> +	u32 slot, u32 vector, u16 vector_count)
>  {
>  	int cpu;
>  
> @@ -1702,7 +1702,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct tran_int_desc *int_desc;
>  	struct msi_desc *msi_desc;
>  	bool multi_msi;
> -	u8 vector, vector_count;
> +	u32 vector; /* Must be u32: see the struct hv_msi_desc3 */
> +	u16 vector_count;
>  	struct {
>  		struct pci_packet pci_pkt;
>  		union {
> -- 
> 2.25.1
> 
