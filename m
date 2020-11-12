Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBEA2B053C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 13:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgKLMzz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 07:55:55 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:13802 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLMzz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 07:55:55 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad30d30000>; Thu, 12 Nov 2020 20:55:47 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 12:55:36 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 12:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyIW7IOM0+++D4M++knuxpj7alhdYeaG22sc6dnPQJvngD6iTQvoKuFK3btnmgz2x5yqp2KUXW8gpJDEBdEvtEjNVEU+Zg1UHlyDVRTAXy/CRaAAshslESeA8XtvD9CNUSi5fQw1W/emZlcqGsBZni9eCp7dwc2n18TqXLtRVzzftvL8iAHZnki7/0gMua+yf1LU6I2Vi9Ryc9MtQ3bYLON/ejRZETiohSE8rkOel8ShqC5HGlLy5WVj5K49GrvhTwQ9bnRTURwNdW9PHm+9+Lm3Ds27QwQru7/BDW33MSTzo8ZlWlhMymu3rYrEycSfJsaw8+nCgsb+WHf+Hx7KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odkGYsTueGG1Oj1E5+/FEqJBoN5zCA2wnbKnOv3SBSE=;
 b=joeixh4hu5ooTwctsGDAchHhtySQy59tD6tksNFsMczPvsiyyWuzacJauPFFKPZyCHv0IzmOqJaVJq3IwPU71DE7W5hi4kyQEyR6pJIxlSE2XuQcPvjQ4yLf3y6AVksI30sPG4CH/p0/c42VC6zzDIaNOS3iyIN7a4GQHtRk45P0ZWoJCF7P/gyZpqD1uxRRmTdun+D7uF0L7uTvzzcjoMqR8cOI8o/r2s2Lw7FgyBfaTwc4uBJ21Wt1CdBu5vAuD3ZVNz5IjO6f4b1uqtB6rxz5Wi0BUV7nwqfmviq43rTvsR0bX8YHYEt8oDBApe84NJk4YnGpc9atCfbvSXNNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 12:55:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 12:55:33 +0000
Date:   Thu, 12 Nov 2020 08:55:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Jon Derrick" <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Megha Dey" <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: REGRESSION: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare
 for device MSI
Message-ID: <20201112125531.GA873287@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200826111628.794979401@linutronix.de>
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:208:1b4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 12:55:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdC8R-003fG5-Cp; Thu, 12 Nov 2020 08:55:31 -0400
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605185747; bh=eQ25xNlY3rVx34V0CM4Bnq31qnmUxB4lNkLgF/NTCTU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
        b=VsWoaT5gF6t9jiuouhEpEGN7Qg7rtC2IuOTe3e6QAc+/J5kvbsUGMZeN9Kt4v340c
         KVbRoCH9TR2N9HqJF4VZ84B6k+51zu6l3inP6l0HJqan+cR7kEEn/+Cqpds/KwjSEr
         BJf+0jPEtmRpSIm1ToZML8tn4g1PO1iVyJXs6pHwlKZwUso5Cn8iCe6LGFBRQ1tEUP
         95Nt8mKzj2PmKuTTS2AowvWwB9kBFIAxLC7TFNHrpa0/KKU1hbM20l9NiG3hCradK7
         hY1uGGNICjBrlcYzyYVoaC3ibvjfkHv7m8xxytVcHuVd6aNpu8YGZow8Vv5rsi+u+9
         YDb6R/lLzsueQ==
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)
> based devices in a halfways architecture independent way.

Hi Thomas,

Our test team has been struggling with a regression on bare metal
SRIOV VFs since -rc1 that they were able to bisect to this series

This commit tests good:

5712c3ed549e ("Merge tag 'armsoc-fixes' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/soc/soc")

This commit tests bad:

981aa1d366bf ("PCI: MSI: Fix Kconfig dependencies for PCI_MSI_ARCH_FALLBACK=
S")

They were unable to bisect further into the series because some of the
interior commits don't boot :(

When we try to load the mlx5 driver on a bare metal VF it gets this:

[Thu Oct 22 08:54:51 2020] DMAR: DRHD: handling fault status reg 2
[Thu Oct 22 08:54:51 2020] DMAR: [INTR-REMAP] Request device [42:00.2] faul=
t index 1600 [fault reason 37] Blocked a compatibility format interrupt req=
uest
[Thu Oct 22 08:55:04 2020] mlx5_core 0000:42:00.1 eth4: Link down
[Thu Oct 22 08:55:11 2020] mlx5_core 0000:42:00.1 eth4: Link up
[Thu Oct 22 08:55:54 2020] mlx5_core 0000:42:00.2: mlx5_cmd_eq_recover:264:=
(pid 3390): Recovered 1 EQEs on cmd_eq
[Thu Oct 22 08:55:54 2020] mlx5_core 0000:42:00.2: wait_func_handle_exec_ti=
meout:1051:(pid 3390): cmd0: CREATE_EQ(0=C3=83=C2=97301) recovered after ti=
meout
[Thu Oct 22 08:55:54 2020] DMAR: DRHD: handling fault status reg 102
[Thu Oct 22 08:55:54 2020] DMAR: [INTR-REMAP] Request device [42:00.2] faul=
t index 1600 [fault reason 37] Blocked a compatibility format interrupt req=
uest

If you have any idea Ziyad and Itay can run any debugging you like.

I suppose it is because this series is handing out compatability
addr/data pairs while the IOMMU is setup to only accept remap ones
from SRIOV VFs?

Thanks,
Jason
