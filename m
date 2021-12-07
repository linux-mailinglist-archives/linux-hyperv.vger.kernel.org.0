Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA546B46A
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 08:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhLGHvO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 02:51:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48758 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhLGHvN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 02:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C60ADB80E8B;
        Tue,  7 Dec 2021 07:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB93BC341C1;
        Tue,  7 Dec 2021 07:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638863261;
        bh=GJEc5bHESZynwTkpKatK/sv+Oau05bPz5qOKd1zBMSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLhJjK7rO92G8d3WWjG7tWRQ+BW+rOaBX5Ee1Gl0gD+5ddO+i5XQqu+JCB+cbG68P
         X06bBa7EJYZKAsQL6qvCO228/ql4ENSodj1f7Q2N+ZvtKwZka/F+1QUWjQmaE+zFif
         LbTeWJgFzo/EHaecJ068/cqfOkongNyBJMpNwFYI=
Date:   Tue, 7 Dec 2021 08:47:39 +0100
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
Subject: Re: [patch V2 21/23] PCI/MSI: Make pci_msi_domain_check_cap() static
Message-ID: <Ya8Rm/cmS4054OvP@kroah.com>
References: <20211206210147.872865823@linutronix.de>
 <20211206210224.980989243@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.980989243@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:57PM +0100, Thomas Gleixner wrote:
> No users outside of that file.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

