Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4B59641F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiHPVEa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiHPVEa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 17:04:30 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F986DAC1;
        Tue, 16 Aug 2022 14:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM/ZJztnKCoDkcKyi9j9G9aOeYnre446zPwmNmgRnp1JuJ37ueOZyobY/gKgGi95Zvl30P4LXP3+e8txdrVTwxYIEa0z2tHD0e4svH8Vl+haRPX0IBkeVsgm7TpFVwaVPWToFt6cRUEv4Kv36UUzDRKBSt3Wumja+7Al3g9T/Teg+dKRV3fwAEqa9pS/iwJPIh9Lz9i9ooG2WT4fEraJxt+NeNDdUo2WkX4bDx3Ql0ELLt4gHbYWQ8Bx97JRe/Pexj0oZyjzSBpE0B7clwyCoZxjPJvoygSRxPHLx1NVhZik/QI8tK8k/UAg9pXVhfwGRM3ZqTpwL+3JhVMVm+SqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGevWo/IU26H3lPcthzMJmP2CVILLzp3yUOgEeUPJ2Q=;
 b=D2iV27UwUZGZT/76rF+KmDh7dR08aWD69WueAss947FCZOeQMF2OoFGCbM0ORM6lRK+zm3ROd2u1Kn2sVwSDuoSWsrjEwHU0vzISK9ogMSKCZhjuyrMd0iP6FcQ+eUOn4iU0UkKtCvrI51v7Kk1KnMr8rsthOeT4aIxFivK+wm1LNDUloTGShgiURvo8DhBMt+ma8LkSFPmN70DLmJWsjnO3FFgszffXjIO8MyYtvixikMg8LToBvbZSiX7t2R1GUBGi6XOEh//6VreQx22O58o7zyD08m7UnRAM2iAoOn0UL0ODSwjZ4VqOs/K6cboRsD5RLjzQlGRzGRoLn2or8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGevWo/IU26H3lPcthzMJmP2CVILLzp3yUOgEeUPJ2Q=;
 b=VB5QlIlbIS6zsZaf+pG+6S74UTeC3xuW/R1QZAUAT9tCI73bV7068iNubJB1mOKaRNBwouqSRKsN+32fCd4OFRVFmsxoB6YreCHAH8k9uoqZAvQ9p3Yor8p9CKnZnudlPh1VPgvHJ/jkC5jCwoO5na1fcXk594C84hNTRQOAf70=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1391.namprd21.prod.outlook.com (2603:10b6:208:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Tue, 16 Aug
 2022 21:04:26 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208%4]) with mapi id 15.20.5566.004; Tue, 16 Aug 2022
 21:04:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: RE: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHYqA2nr0ByY5vvCEupYVpg2kRVKK2os23QgAkLdgCAAEMDAA==
Date:   Tue, 16 Aug 2022 21:04:25 +0000
Message-ID: <SA1PR21MB1335D08F987BBAE08EADF010BF6B9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20220804025104.15673-1-decui@microsoft.com>
 <0f19cc67-ccb1-7cd1-5475-d2ec0e1abfc0@quicinc.com>
 <SA1PR21MB1335D9CF9F0B1C101F15E047BF659@SA1PR21MB1335.namprd21.prod.outlook.com>
 <Yvu8FJfWkWX3rhO5@lpieralisi>
In-Reply-To: <Yvu8FJfWkWX3rhO5@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=57ddfb8f-919f-4a56-b856-eaf3a29982d3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-16T19:47:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1697abc-0a40-43f6-06c3-08da7fcae6c2
x-ms-traffictypediagnostic: MN2PR21MB1391:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9hn/gpyZxb56fBPXLDyMyT3UB/0TggrSjICryqKqMjp+K7FGLkr5dggneHc9Vz6XDIvT26acJraq+uCPFkjGwUyb13dqPOvCoiuDyIh8xqNMl8jCdM0OkRCVSmxUlhiBf0TyMisLNT5CXFD5i5nxGE7KqvLTS0tzOUwJuzj0B84BRHRTo4ncJExLvMLbwAdNXYUOkrgdK89d+hnwdOlMGOgT0Q3XCMglVPklua/XyCnGxpBc3JMon1WCJZYq292ESIWQK/iogBx2C+JZkHb/5jA5VkUW4GLDPR/xi1OKKKoXX7NBe0grKmug1A483sj+TgNNxa3dLP2+iAmJ4bTndforK7KLjDZY0UfWYDWNNMnmFkhe4vMyCUBTisjQfwtEMTDNGaTKjZUAf1ImyiHe8NXnLef7zwcF2Ubul0On5fwLaRkFmZDUfEM/J/lkzAbqcRR672PPxM0ddojCCTqwhX/ueZTUyysJKeE0000bxycry5W/ffUbB+MESURRmlWzYTAPhCawYMdwp6svs/smFa/+/Nsb8Mnd2N36dhkyqKMDVs3Khjsi4pYL/CUX7K/BpswKUg+8sl5CSe6LGubSinSi4mUuw7v5q9D+IL75zfGfVQnYI6fFUDb7qrWEjpUzGw8qcRpL0OPGrXsPgcbV5cQvoEnT7C0fzd/dUSjYgV++lTVkdR2EjJS+NY8UqLaVZKkbOA0V1ZSUTp6pNyBY62SHSBAmLuq1H1ov9Osy7SUJU883SThrJhWIq9SKVCMKELhUkA0thUSrl+YH3Q4El+Sq8PKdM1v1XKYgU8R80GOWh2XQlvMlRvEKwiQ3iJa1ekLEKuohVPrPhxYu6wRWdZsG1ieUNhr5Cx2HrtuHfss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199009)(83380400001)(8936002)(7416002)(5660300002)(186003)(38100700002)(38070700005)(82960400001)(122000001)(86362001)(82950400001)(26005)(6506007)(41300700001)(71200400001)(478600001)(53546011)(54906003)(110136005)(10290500003)(316002)(7696005)(9686003)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(64756008)(55016003)(52536014)(8676002)(8990500004)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GxbUZL+goHtcSqN3I2rb8YAz7FJcBq94WMSRSBPCpk0G2YSYR8FSlX7xq/H4?=
 =?us-ascii?Q?rXhvKCOoJCKtW+17j4xFhNw88+1MQkv76aGl80LcLplw+sFxmKEdNjOTJcJU?=
 =?us-ascii?Q?k/gtM+h4qPGcLawC9Ww0C3Tqb/cHsnNfS+dwVQwISKX9WoN3r7UogVTZH/bP?=
 =?us-ascii?Q?i7Dki35mDxXmfp5JxphArsXvrJhu3FuVfbstneif5bB9lp6hnlqnWwH6TTFa?=
 =?us-ascii?Q?1jE3uPDyV0beQMb1Q2O40/m+TFWatFOtuycEwiZXxw+XQYo2fQcjqRxLrFeb?=
 =?us-ascii?Q?eKwynFgg+iq7ni4oX0vP/bpl/C+HxWUxLyJaUAbFN5W5FAnAHkMXwbe+73Ma?=
 =?us-ascii?Q?IjUYHycigUyO8lKKTBwUlPWO8Mp1wb/CseHBOX8tDzjGMVcVSSGnj999adNw?=
 =?us-ascii?Q?hm2PaGFla0jNRG6qy5IIYudSA2kEtulbTqBpXmSbGqIDFr8pIrUb3Yn9FeTm?=
 =?us-ascii?Q?eITOCOQZLS/PjcCYi1Sy/4axpV3YEBCXUA8YOxFEYnIVxn/uhHFtygysRtRM?=
 =?us-ascii?Q?87/yFW+TbV2JDyQGVpdaq6hMQvO4C5RjSo/d3wQ8b5XzgEGCEN3/O1ghAXSZ?=
 =?us-ascii?Q?4XRiuGIIBMXspa1UNvRioVsRW9Y7Q3AYToSom2esInpFQgaZB8EybsJ2vrgs?=
 =?us-ascii?Q?7/YnCk55g3/1juk4wMVYeVmHDs4q6qquTaRbgoPlFMf3YsfrdA5vjQr375UL?=
 =?us-ascii?Q?v8Y0AHvHLinTyEhjCdij83VBlXm+0wVAC0Ug2eJE5jEoLkkPZkgLte8eAzez?=
 =?us-ascii?Q?x56Zh7xNKLFuCdsKtfkqJ2XistjbcOqYpNHI0xd4rnEeXzDrTY/p9RtWSBlz?=
 =?us-ascii?Q?2y+mfPbylmmFX3xnRDR3CXwBQ0BM8NcX6IKPmlxr0Jh1paQw+HS83LRrwe82?=
 =?us-ascii?Q?FllrD8lwIU+c4iBi4ChsQbNb8cp1y1vq87dcFzx9FuArEdh/YGsagVASTp6S?=
 =?us-ascii?Q?ONV+RGAvuM7/ptarb6oaMUfktaeF43BYaQeRGYWLq3KchPTEn39JX/nuCf8H?=
 =?us-ascii?Q?GnyQLdRdaR9m6GI2Q1d02ep1bHNZDopV7WWzEuqPHYtK+Ixr1g5ZjH858BQY?=
 =?us-ascii?Q?vHtkYYSillqWcwwrlOJP/Wevb3/6FadqtK9ah6uze/qB84z7uHwhcXvTzjnY?=
 =?us-ascii?Q?nPCvjlUiQwuWzRDqcci53XIlB+QDtZvEQLYhlyB6UL7QKSj5fa2bA0gE3nik?=
 =?us-ascii?Q?D2EYgqZeKgyUVgjAy8hWFR/GIDmVuQNhRZDOyMux38W304bRUzl6DXhSjRlT?=
 =?us-ascii?Q?aghg7vQ14+sbfo6E/nJBOI7nhWej2ph4S2AsbD44rQuUlbBrYF/0Fcwk3wuq?=
 =?us-ascii?Q?Y0gciQYBFODE7rVtRsMZ8CyjAEDv5RRsUSq/UjJbIVpFGJu0UWDujT9pW3az?=
 =?us-ascii?Q?Fxnud0DZ1KHbxWAf1pjZv6uK+yrU+6ovd1NGW3Vmct4rGI7YOHaZiu1+mFJ/?=
 =?us-ascii?Q?mWm+5utEvRpraVtzofgQ3uOXZu8IgJLufPFR6+kDsyuPZ35lWe/FPowvC3Ce?=
 =?us-ascii?Q?/1iZ5UBfVeSaO727s8/tAqEkNKragjKWkAao0UwxYNw8N8n3xEG+gaMCISLB?=
 =?us-ascii?Q?KieovYL28lPeiI4AKdZzbzaMa8yYYFaXn+JkYs1D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1391
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Sent: Tuesday, August 16, 2022 8:48 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Wed, Aug 10, 2022 at 09:51:23PM +0000, Dexuan Cui wrote:
> > > From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Sent: Thursday, August 4, 2022 7:22 AM
> > >  ...
> > > > Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in
> > > compose_msi_msg()")
> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > > Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> > > > ---
> > >
> > > I'm sorry a regression has been discovered.  Right now, the issue
> > > doesn't make sense to me.  I'd love to know what you find out.
> > >
> > > This stopgap solution appears reasonable to me.
> > >
> > > Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> >
> > Hi Lorenzo, Bjorn and all,
> > Would you please take a look at the patch?
>=20
> I am not very happy with this patch, it is a temporary solution to
> a potential problem (or reworded: we don't know what the problem is
> but we are fixing it anyway - in a way that is potentially not
> related to the bug at all).

Exactly. I understand your concern. We're still trying to figure out
the root cause. The problem is that so far the issue only repros with
that Azure VM SKU "L64s v2" (64 AMD vCPUs, 8 NVMe drives, 32 I/O
queues per NVMe device). Unluckily I can't find the same hardware
and software locally. I tried to repro the issue on two local Hyper-V
hosts with 4 NVMe devices (8 I/O queues per NVMe device) but failed
to repro the issue. It's very difficult to debug the issue on Azure (if
that's possible) because we don't have hypervisor debugger to examine
the hypervisor and the hardware (I'm still trying to figure out how
difficult it's to set up the debugger).

As I mentioned, b4b77778ecc5 itself looks good, but it changes the
behavior of compose_msi_msg(), that has been working for many years.

This small patch restores the old behavior for non-Multi-MSI, so it's
safe. Considering we may need quite a long time to get the root cause,
IMO this patch is a good temporary solution for non-Multi-MSI.
=20
> If the commit you are fixing is the problem I'd rather revert it,
> waiting to understand the problem and to rework the code accordingly.

IMO we should not revert b4b77778ecc5, because Jeff's Multi-MSI-capable
PCI device needs this patch to work properly. It looks like Jeff's PCI devi=
ce
doesn't suffer from the interrupt issue I described in the commit log.

BTW, Multi-MSI never worked in pci-hyperv before Jeff's 4 recent=20
patches. Jeff's PCI device is the first Multi-MSI PCI device we ever tested
with pci-hyperv.

> I don't think b4b77778ecc5 is essential to Hyper-V code - it is a
> rework, let's fix it and repost it when it is updated through the
> debugging you are carrying out. In the meantime we can revert it
> to fix the issue.

Thanks for sharing your thoughts. IMO b4b77778ecc5 is not a simple
rework. As I explained above, IMO we should not revert it.

Before b4b77778ecc5:
1. when a PCI device driver calls pci_alloc_irq_vectors(),
 hv_compose_msi_msg() is called to create an interrupt mapping with
 the dummy vector=3D 0xef (i.e., MANAGED_IRQ_SHUTDOWN_VECTOR);=20

2. when the PCI device driver calls request_irq(), hv_compose_msi_msg()
 is called again with a real vector and cpu.
  2.1 hv_compose_msi_msg() destroys the earlier interrupt mapping..
  2.2 hv_compose_msi_msg() creates a new mapping with the real vector/cpu.
  2.3 hv_arch_irq_unmask() uses a hypercall to update the mapping with the =
real vector/cpu.

(BTW, hv_arch_irq_unmask() is also called when irqbalance daemon is running=
).

Step 2.2 and 2.3 do seem duplicated, but my understanding is that this is
how Linux irq and PCI MSI code work.

With b4b77778ecc5, we no longer have step 2.1 and 2.2 (please note
the "return" in that commit). We never tested this code path before
b4b77778ecc5, and we supposed this should work before we found
the NVMe interrupt issue with the VM SKU "L64s v2".

The strangest thing is that the NVMe devices do work for low IO-depth,
though the read/write speed is a little bit lower (which is also strange);=
=20

With high IO-depth,suddenly queue-29 of each NVMe device stops
working -- after the NVMe devices are initialized, hv_compose_msi_msg()
and hv_arch_irq_unmask() are not called, meaning the MSI-X tables on
the NVMe devices are still the same, and the IOMMU's Interrupt=20
Remapping Table Entries should also be the same, so it's really weird
the interrupts on queue-29 are no longer happening...

My speculation is that there may be some kind of weird hypervisor bug,
but it's hard to prove it with no debugger. :-(=20

I appreciate your thoughts on my analysis.

To recap, my suggestion is that we use this patch as a temporary solution
and we continue the investigation, which unluckily may need a long period
of time.

Thanks,
Dexuan
