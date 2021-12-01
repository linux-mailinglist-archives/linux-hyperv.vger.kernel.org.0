Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A2464BF3
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Dec 2021 11:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbhLAKvk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Dec 2021 05:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbhLAKvk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Dec 2021 05:51:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C29C061574;
        Wed,  1 Dec 2021 02:48:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638355698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKVDaayb9Z/Ddig0Fl/GaJFR9P6OWvMrHeuR0/MtGo0=;
        b=2ZakPGx22bgcebPzdNcjjRS3Y+6bDCb8UqLyR772WTqZ3Dp4UaYXmOk/PEQcTyOQ7C281b
        bPOyziVy1+KZVMw3CGvc+ExOnUo3TGdnz0i00ne5c5xhE9SdM/59qPZ0xTYuY8kFfCRJHa
        wcobwbC4oDqjpMDdFFfLEhfZrKdXImuDjnGTDbe68FOs6Usz9scL95/c6U40dk3gLSwp4H
        hFcMKRQNY/TUSQIPtN1M6bsI7K7UFwZ9DBl1XIRPJr+91AHdW2Vxfy1MGQffna5JvbHjBr
        uAxbtarLA9tARJPPzvIH6mf2U5yQzqI1DPvadU9/jGsPDm2ZYxczJgvoUPA9sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638355698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKVDaayb9Z/Ddig0Fl/GaJFR9P6OWvMrHeuR0/MtGo0=;
        b=qy6yHYx5gu2MckULeM58AC46b3/lxjDG+QCdq/u8tP1cQaKsq7O2NcCTYCu267QpY8omHJ
        23N9eC+QYS1K/KDg==
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-hyperv@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        sparclinux@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>,
        x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Kevin Tian <kevin.tian@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Megha Dey <megha.dey@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 05/22] genirq/msi: Fixup includes
In-Reply-To: <39556bdc-f48c-68b2-6bec-5975b92e02e2@kaod.org>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.382273262@linutronix.de>
 <b1a6d267-c7b4-c4b9-ab0e-f5cc32bfe9bf@kaod.org> <87tufud4m3.ffs@tglx>
 <524d9b84-caa8-dd6f-bb5e-9fc906d279c0@kaod.org> <87czmhb8gq.ffs@tglx>
 <875ys9b71j.ffs@tglx> <39556bdc-f48c-68b2-6bec-5975b92e02e2@kaod.org>
Date:   Wed, 01 Dec 2021 11:48:17 +0100
Message-ID: <875ys8a9e6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Cedric,

On Wed, Dec 01 2021 at 08:14, C=C3=A9dric Le Goater wrote:
> On 11/30/21 23:41, Thomas Gleixner wrote:
>> It's not the core function. It's the patch above and I'm a moron.
>
> All good now. Ship it !

thanks a lot for testing this and dealing with the fallout. Much
appreciated!

        tglx
