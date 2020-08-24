Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41A24F200
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Aug 2020 06:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgHXEsy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Aug 2020 00:48:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgHXEsx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 00:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33352AAC7;
        Mon, 24 Aug 2020 04:49:21 +0000 (UTC)
Subject: Re: [patch RFC 22/38] x86/xen: Make xen_msi_init() static and rename
 it to xen_hvm_msi_init()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.464203710@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <1af3d4a2-0f73-4e58-0e23-ac667d2c9141@suse.com>
Date:   Mon, 24 Aug 2020 06:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821002947.464203710@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21.08.20 02:24, Thomas Gleixner wrote:
> The only user is in the same file and the name is too generic because this
> function is only ever used for HVM domains.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
> Cc:linux-pci@vger.kernel.org
> Cc:xen-devel@lists.xenproject.org
> Cc: Juergen Gross<jgross@suse.com>
> Cc: Boris Ostrovsky<boris.ostrovsky@oracle.com>
> Cc: Stefano Stabellini<sstabellini@kernel.org>

Reviewed-by: Juergen Gross<jgross@suse.com>


Juergen
