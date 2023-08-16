Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB80B77D954
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 06:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbjHPD7h (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 23:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbjHPD7g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 23:59:36 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCC81FC1;
        Tue, 15 Aug 2023 20:59:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbutYFo/j6yl45kokquQN4KnFCZJptP2pOCqGsH5AZW4iozVZJbPRydBe4Yeu1oSMJ1CaenZgDo6+buscYT+PEPYvcNJvLhgWmNJphGp/avyy3xRbw/wZDQV62VtSE86K+SAvwxBY4Up5brF1XtsQA7BlD7MjcUE5FuAuSaBia5r87cB4ZXr+ZPKEQtr+zvlRW/hdDtRWbKvkEQmVkW5TbRawR5ZGRgE0xY3Wls9AtpuJfCiv85B175r2Ju3zQ7D6VlCUL5QpHKtogG0yqohblc+tmiTHcP7AhIN/RX/87FfO1DE0tYxMFdyZ+tl58Q4IqYMtA203E/eaTTrhTtodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNL236LAJ0yqJc7y+VMv7CHbnUs0bGaTpNNRnBUdekU=;
 b=Xgdd8RrpzgusOu1erq/7d+9Jb4PUYXt7HDP/CudUZ3vPXvIjQOdZED2b0FqvZOnmNV84dTU4K8tl5m2mNoaeTmeZ8NIWSyNs6KR3WQrrW1bbWPJYIYg+u5ZF5ZeLsG3rawYTgB/037Ex4Kah8v0qjLFNsMsSk/4N22jrVtIOOHmrE6BA3W9K8KTtqBoBoimbbiSd2SdYvYMepG/eaTJacZx+FxBEqD0KcsHYZ/GuaOmXYcMAw9Bp1EHPREscqK2V27UW8dZ3z4U6mFXhf6jLo2KUCGBj0B22HLEynZ22u7bDt64qll2aIGBNEI5p3OYavh18BqVi8+YnaDcGP5JepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNL236LAJ0yqJc7y+VMv7CHbnUs0bGaTpNNRnBUdekU=;
 b=JXgdg1RXhh8AlC04kmlVf8naEbAgNR3fUL2uL9wQKWUCOXLLa2YjgNkiMR/aRDXkXPaWMZdKOa9JVLn0W39jIHPv8d8YtFAHJ+QTT9Qdv6i1iSipDc1/b52bZVxI1HrP4FKo9CNUE95Wzlg0O5e2TuA1EoZtmL6W3mGQRL2qDvg=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3103.namprd21.prod.outlook.com (2603:10b6:8:77::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.3; Wed, 16 Aug 2023 03:59:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 03:59:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during
 hibernation
Thread-Topic: [PATCH] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during
 hibernation
Thread-Index: AQHZzXrpqqhsyu6SnEq5GlDNhSPBZK/sFCqQgAAUKZA=
Date:   Wed, 16 Aug 2023 03:59:31 +0000
Message-ID: <SA1PR21MB13357832AE84D20073CDA9BABF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230813001218.19716-1-decui@microsoft.com>
 <BYAPR21MB1688E86B4DB69DB8F3796DDED715A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688E86B4DB69DB8F3796DDED715A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6ba78a7-fcb6-4ad8-93e4-b5c3c340b1be;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T00:21:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3103:EE_
x-ms-office365-filtering-correlation-id: 466fd0d8-03ce-4524-4f0b-08db9e0d322b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKl1rqkwrMxcHUqhumRHAZ5rhE8LgJP+PjUDi94nrZUeC/W7kXXNEIACkHjvmFygTHr/lj+M2nZ5z9p9f7uZ5QnUKD102nmDiTKCapnxF+Kq8MOjqXOQxeW+AMFNU/ZB+PkyVP4A9fooqKDtfqMc6VBWl7co2Bl2ezUj10HG0nbpkl7ZTesBlSHE+jQpHrAt7VYLqdD9GybIaCj23MWby0YFxyncyeDPTzAer73E+mY2ouGWIqNjT0JCTtpLRaDWC9E5baw0DbXvaSeuDDrBpSjq6VWMN7L8pQvK0vu8aSuXl8Pw51chnyKbQU9gN+tUB8pjlK6hmks806Sjkw6z1fvu2D4p4qzfycp2rjrQldTi1gZmOUJJSsaebjFsFdpNzjB6SYkG61EYQH1qJ+K4D0eP0662SPFrig5EpCywOQgMAOOhhVcgwQSysbkCYnAmmRi+VFiobu3zXEK+LOxOEHGCUepKmGhG50pT6dGZ4XGn3fK9aLgqvST80zevhsHYxTEpmLo4E/IJRh/KFHyCnAbRB6K4F+Cfl/t1xI9BTSXZKIvX2WYw0FqtkhrwIDAnJKN3zuRtHb0Jh4r93z+7oFIOlXM2pS6Ew1PL3D+Rpa+QA6FgAVWtaYAtQwmkWANhwAUCRfcNOJj+a1K+cgw0ea03JaVKqU+LkijDRTJXUqZEPzDTNTAkTjqB9A8XYaopgm4pDNqIqkNEkSV4VSOCxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(12101799020)(316002)(66476007)(55016003)(71200400001)(26005)(66446008)(6506007)(4326008)(2906002)(66556008)(41300700001)(66946007)(64756008)(76116006)(5660300002)(7696005)(33656002)(9686003)(7416002)(83380400001)(82960400001)(82950400001)(10290500003)(110136005)(38100700002)(122000001)(38070700005)(921005)(86362001)(52536014)(8936002)(8676002)(478600001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XcfoyjtOhTTydaZH1Pk33Y/rIQbp9iqZqh1B6Kz0RgzH7afAoOHpu8mUHxH7?=
 =?us-ascii?Q?MH9QJ4XAjui29SuU2nmfoEL4kZtxPn0Y5fQuVqHvdw/XExWItOgHBkiWdHxm?=
 =?us-ascii?Q?TSYdpUjk1IZGCqU1ap4BEYUIf4v6ZXVTs7HDwr12jximk9cipzo2+IGNalEe?=
 =?us-ascii?Q?qtP38UWhhJu5R9roIghjPSEpbc5Mf+ySSj39j+/wAnJsyUa9Jtj4V1u7sFc3?=
 =?us-ascii?Q?d02HGAmbyYXlVsys60HW5EGg/zKRRi/jbxo+XBYgaUVJnk/Q+1UF6R5udeB8?=
 =?us-ascii?Q?mVho4ObLdJ1rd+OJdo+/nUO192JpXmhDjLKMng5kg8ju0TZdYlDDj28V4L+K?=
 =?us-ascii?Q?tz5OeusoIW61PF5uOTf3V3gtJTRYRQWgB5qELWMOxQu1YeISaOt5j6U1odbm?=
 =?us-ascii?Q?b8u7QtE7i1s6MtxHqc7EYdhzECRQde/GZFa0gbhPtNIAu3x7ED90Vmqz64IE?=
 =?us-ascii?Q?94c+AhdPLjwbVXu0NQ69TkRnahbs9wJetofJGDLu5WZPcFbveWOLjHMmMqd8?=
 =?us-ascii?Q?r44SG/bzwko8Lq5SVhjRgWZ2wmx35pj8BEC6upkGdYX6nWvGu58NiUY4OFid?=
 =?us-ascii?Q?iHvSCYQdMZpxwK4fsJ/izdU8iV0CXM1ByXA/Bh63hbEjZuJLR9O69GKTwerD?=
 =?us-ascii?Q?vN2aCCrS5ay3pnR6trtfYX+ZuhwpwLCuQOYwl1oRKjqEUqsdol7W5VOqqZMl?=
 =?us-ascii?Q?dXEg10vt8EVjrLrCCq2WeQHVxJom5dQ6H3PGKj62gL6drtD9FwjRB6zVLeeQ?=
 =?us-ascii?Q?+J3n4seUn5TYr0pTNR9hQpU9az4pHPGXolu+sz8ezjs8V1+IeiJJ8dqUt2Ov?=
 =?us-ascii?Q?ni1lNG+HRUUVOYNADhPDOG/Fba/z7UFRE3xY+2ltZLCHGazNlxJLkU+NQ+Wf?=
 =?us-ascii?Q?4tdqiVsIkUrCdJSZJvoAJZ2dUiqwbR3unPW4+HJQbMWsnSXDIj/0erybBgDE?=
 =?us-ascii?Q?+EuyCPlAaUZ5+DCyMcU4AVS4yGdoE2XvHPWlk5MbpAHlD1gn2dQJN4IKLQtd?=
 =?us-ascii?Q?fBbEz13UMfM9vaoDC4l5a57SRKaxXZYMOWulipjg0h4jnlMSeuxgM6AfzpBs?=
 =?us-ascii?Q?U+4wCA/3CUsQWDSmryBIRBjbL4VlmsPcoGinQiep3Px+Hnbv6ZCBUQxowL1v?=
 =?us-ascii?Q?04g0LltvM5ghTZGo3BTw16nxpVKUb4Dx++zdxorO38OqPqHl5hJDhEH5eQnK?=
 =?us-ascii?Q?dHc0WZ2tAGobqJQBsbHPyQbNWKLqV9xJCBoxsh/CGpbVowYB8ECB7JrIq5F5?=
 =?us-ascii?Q?GhcS8pfBtDKblMxfxMOjKOlQUIZW74r8B+fuqLl5UCVhJHpOkzEGMo7hNwrZ?=
 =?us-ascii?Q?dKKR39tB/+5P2qSVqrwR9UZCM3yok9/zJW9jQmrLzG+7HjC3uRfYg4OXUelu?=
 =?us-ascii?Q?djiC0RPAnmys917322ZGXXMmwYr+D/nt80ou8xnICo/bWYnlCYrxmM7+8KNu?=
 =?us-ascii?Q?bAsad43fATrhwArlje+rxaHhzkg5t5LlTOrfSwI+kqk/NYn7iYYgLB+w9v6V?=
 =?us-ascii?Q?wyMmuTNVvV4RRUMVIDbY1KaP6RfNTBMKw+5k9SfX3Db9/UPCYlbpxmFcS/bX?=
 =?us-ascii?Q?itDJeiG0ACWBrRUuvVio8XMdDn7gtgQ8O/wVAB1z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466fd0d8-03ce-4524-4f0b-08db9e0d322b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 03:59:31.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhX5JJpLARrMUheyRdKfsqi2didVFDEFFWli3Sxm2UK/LACydtxVT1kYK6IDdcXpSdKbLtWZnomzJEhHjovHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, August 15, 2023 5:35 PM
> > [...]
> > For a Linux VM with a NVIDIA GPU running on Hyper-V, before the GPU
> driver
> > is installed, hibernating the VM will trigger a panic: if the GPU drive=
r
> > is not installed and loaded, MSI-X/MSI is not enabled on the device, so
> > pdev->dev.msi.data is NULL, and msi_lock_descs(&pdev->dev) causes the
> > NULL pointer dereference. Fix this by checking pdev->dev.msi.data.
>=20
> Is the scenario here a little broader than just the NVIDIA GPU driver?  F=
or
> any virtual PCI device that is presented in the guest VM as a VMBus devic=
e,
> the driver might not be installed.  There could have been some initial
> problem getting the driver installed, or it might have been manually
> uninstalled later in the life of the VM.  Also the host might have rescin=
ded
> the virtual PCI device and added it back later, creating another opportun=
ity
> where the driver might not be loaded.  In any case, it seems like we coul=
d
> have the VMBus aspects of the device setup, but not the driver for the
> device.  This suspend/resume code in pci-hyperv.c is all about handling
> the VMBus aspects of the device anyway.

Good point! The bug also affects other PCI devices, e.g. if I unload mlx5_c=
ore
and let the VM with a Mellanox VF NIC hibernate, I hit the same NULL
pointer dereference.

> Assuming my thinking is correct, is there some Hyper-V/VMBus setting
> owned by the pci-hyperv.c driver that would be better to test here than
> the low-level dev.msi.data pointer?  The MSI code rework that added

IMO there is no easy and reliable way in Hyper-V/VMBus/pci-hyperv to=20
tell if MSI/MSI-X is enabled for a PCI device. We can potentially track the
MSI/MSI-X irqs in hv_compose_msi_msg() and hv_irq_unmask(), but
IMO that's not very easy and may be inaccurate.

> the descriptor lock encapsulates the internals with appropriate accessor
> functions, and reaching in to directly test dev.msi.data violates that
> encapsulation.

I agree.=20

Compared with:
	if (!pdev->dev.msi.data)
		return 0;

I think it's better to use this:
            if (!pdev->msi_enabled && !pdev->msix_enabled)
		return 0;

pdev-> msix_enabled has been used in many drivers, e.g.

"arch/x86/pci/xen.c": xen_pv_teardown_msi_irqs()
"drivers/hid/intel-ish-hid/ipc/pci-ish.c": ish_probe()
"drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c": pvrdma_intr0_handler()
"drivers/scsi/vmw_pvscsi.c": pvscsi_probe()
and more.

So it looks like pdev-> msix_enabled is a legit and stable API.
I'll post v2 with it. I'll update the changelog accordingly.
Please let me know if you have concerns about it.
