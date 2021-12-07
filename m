Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8850A46B472
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 08:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhLGHvv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 02:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhLGHvu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 02:51:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9153CC061746;
        Mon,  6 Dec 2021 23:48:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 563CAB816BC;
        Tue,  7 Dec 2021 07:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5387BC341C3;
        Tue,  7 Dec 2021 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638863297;
        bh=987va09/dvP0ztOLf5mXiuObxbrtwLhSB7qczYAr3zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaiDHF8b4ZwfaykbIRoAGImv/wOEYnC2OuRRekPTUvnH7Z+KoDN2eitf1+2jyFZYE
         RW+eyBwNessu97qSLx5/+QRYN5pKkPpJcIjhEtARHEOXbvL32YiTSQMez2rOnMK2aS
         hmP2VmZeVihGhwMbl5FyYdeY/dLwK2GtNNuHp+J4=
Date:   Tue, 7 Dec 2021 08:48:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch V2 22/23] genirq/msi: Handle PCI/MSI allocation fail in
 core code
Message-ID: <Ya8RvhfV2j5i0gwg@kroah.com>
References: <20211206210147.872865823@linutronix.de>
 <20211206210225.046615302@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210225.046615302@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:59PM +0100, Thomas Gleixner wrote:
> Get rid of yet another irqdomain callback and let the core code return the
> already available information of how many descriptors could be allocated.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

