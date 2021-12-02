Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657E246655C
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Dec 2021 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358607AbhLBOjz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Dec 2021 09:39:55 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45848 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358563AbhLBOjy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Dec 2021 09:39:54 -0500
Received: by mail-wr1-f48.google.com with SMTP id o13so59961757wrs.12;
        Thu, 02 Dec 2021 06:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xh3pKbxTnj8e62DOcRXknPoUROM+BODLvzmQyRbbH8s=;
        b=kTkJUVvm9rv0ZQUG43Neiaz+fGYCC6wrwa+G2jsjDLt1kflpkMapVaCbF5vFdTw2d1
         dqNvDO38lAR4Keuj9rpfqoQtW0bPlhN5hUEnAr12/y73p/iSoZPLr7aoR+LgAS1K+Dk7
         E/d69xGAiAj3nJVkhRo18Jm/iXykMeFahZxqcb3B4DL/i3B+T1Glg/j9cwmCrZAaupQa
         HGMhFkOuP34wWNBpTGWwUglIoCxe1UD0lJCkdhRSOTY6dKnzBfvV5OcD3nW55JY9Ls/v
         JBy63CA5FYQEfrQEzTkzT2kttEs+XBC0NGWzxwJRg9Xw6u71n4ysGOoTJx7v+rJqEVoH
         zwSA==
X-Gm-Message-State: AOAM532KvjUuChezdZQSDkJGPDuk9oUA1E4GZ7CFxciQlG2rB/ps2oRi
        eTfhzoOx+k2ORBAyS5bDTtY/1qNFOyM=
X-Google-Smtp-Source: ABdhPJwNpcGjwNKyiVWqPz1WBsz/Qi/GLv2M+5yPM20JS1pf2ye6xEbrzai84zM0oO2HmmRa7dC8TQ==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr15988721wrr.614.1638455790749;
        Thu, 02 Dec 2021 06:36:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q4sm2636132wrs.56.2021.12.02.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:36:29 -0800 (PST)
Date:   Thu, 2 Dec 2021 14:36:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Wei Liu <wei.liu@kernel.org>,
        x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        ath11k@lists.infradead.org, Juergen Gross <jgross@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch 11/22] x86/hyperv: Refactor hv_msi_domain_free_irqs()
Message-ID: <20211202143628.dgiikgujigylogoz@liuwe-devbox-debian-v2>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.737214551@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126223824.737214551@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Nov 27, 2021 at 02:18:51AM +0100, Thomas Gleixner wrote:
> No point in looking up things over and over. Just look up the associated
> irq data and work from there.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Wei Liu <wei.liu@kernel.org>
