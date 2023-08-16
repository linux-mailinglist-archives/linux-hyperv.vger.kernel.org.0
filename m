Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3DC77D983
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbjHPEzn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 00:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbjHPEzl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 00:55:41 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0D268F;
        Tue, 15 Aug 2023 21:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDVa7PYfbRB/kAbD6IgjyvBxOOXQtVmO4UMIPIoWSJMs5OlLbNK/EO+O1pR3peiK0XaHJNFcgNgF7sLoGXoyRVOLT3CpHrmNbWx3VkL9omfoY0sHzp/7U87q30wWbUzwScPzCCOhcbOWy8DBkRDheEeniaaNOK+yE8BkvI9/4+AMSs5b1Z4n6JcKukpu1zHz1x2VJv5mYFQ3H4/DMCUhnBWl4pCdM13HF/oKrLGChUcZJcAALrmvFn/ByZ/i2a5vQAWG3MVT3UeOmM3LkPDDFaJcg/Ah3SzUGcs07EM861BpyY9ePMSBsTvdWuDtscPBPJUNN912wZ8MNIjtlPZFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oR0/QpFuzZFC+BaLbFx79AHLsv+AGL6/VA6c402f2w=;
 b=JrvbuaRWJE4rMLX4FWxY6o2DzpsknFqc60ZmDJsQ0JnsevsvLlgLBEn+seJsw0kGMNQkIAGJ0AfTNXMH0uvGDSk/TwJzQgvJTYKc4l0lAapR6PhS0GE34fq+SF2kNF0FWjbGicv0BYdUkOcdVaRbL1WzYi824qpEpV8tutQbEiyVvbkXHJLthpc95VWhuRwF3UNyLWDYk1Va2QgpniRpbnIhmbvk7Qo53X89o/jJItBsmBNWnEoRvcn65oUEEL3GOJoiXk+s+fteAP/+L7pk6hHgxnYfC2zqCz51FdVxOCUxVZzIa2VmY+UDZk12KrrTLDTIY0m/O6X90WNQGU+pbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oR0/QpFuzZFC+BaLbFx79AHLsv+AGL6/VA6c402f2w=;
 b=DHFjgnH4/3CnajdhUEsiTKwefVr3L7fRzSNT69Fmev+q8EZT4pxn5RoyGuBl27Rzbg4gNHZlLfAjEQlR8vE5ZQjO80U5/0E0UebxwG+Uy8cDynSudmizR0pIqn/NPKEBNZcFM7QPaFOmpReuAJYYPLU/Qs7hEvWMoEESGBk38FI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY1PR21MB3966.namprd21.prod.outlook.com (2603:10b6:a03:522::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Wed, 16 Aug
 2023 04:55:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Wed, 16 Aug 2023
 04:55:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AQHZzXrpqqhsyu6SnEq5GlDNhSPBZK/sFCqQgAAUKZCAADgp0A==
Date:   Wed, 16 Aug 2023 04:55:35 +0000
Message-ID: <BYAPR21MB16887E4BF391F977901398E3D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230813001218.19716-1-decui@microsoft.com>
 <BYAPR21MB1688E86B4DB69DB8F3796DDED715A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB13357832AE84D20073CDA9BABF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB13357832AE84D20073CDA9BABF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6ba78a7-fcb6-4ad8-93e4-b5c3c340b1be;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T00:21:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY1PR21MB3966:EE_
x-ms-office365-filtering-correlation-id: 05b26c0a-5421-4a91-f2a6-08db9e15070f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xB1hb1W2bwWHjoR26B9gQV2sqs6m80Co9nMWJE9OaxJq1yWtUOekqAH7aj0G/8lQsdadYO4P7mBvBGJ5mDTRykDclPAu8p3hQHHNJtvdUM2E5R22aNegp/Zc0GxoWssKcGROlTZgj3qmV2SM5VDDVTnqdrx+6nkZ4k3Zsxrr19oyE6+TTOPVLvjHzcwi+yh7OGjAI56OKSzpq595yGsh28GsFmQL5GruX7SxuwXlyR5IxkSrVPPC78wsZt3g107yjyftz8FXOnb0gb/GG83ZKkBRCMjlGEZhqV4wgHRVHK+MWOk0ZjCoRv7opRz4Yx62RbkHjOiGOI4vuCRF8nuP90R+3aUTUA+ubvclanBVc6rM3CsW/tCDXOnEDfeOSgsSCXREcBNfK4Fo5eZdYtH1+DGFolTUFBrIPQ1mA6Mt6XwCNsnbpwt3/wGCvR1GK+VMkFZXH1pOabxogOEsNZI87T38YFjKhi7FjZ76zKfC84sPWpUlY2ydPwfbktlp1meh+Xw85Mu3Dkec4A/RYQ7GchMj9uSdIB6fBq+Rst7GuD8KzVU7Kh6INN3G2MX/dkQAXpU9EGTK6ZQKq0am3Zi0HEt6f//JYpyuqHwZ8qvfPPID1QCHSFyXVQlckJIkEKUF5q7j5k7fogKUToI/RzViWBYSoiswRpYUL8jObQ63Kt8oYXewPaaLluWXInCUfFfPloLu3YmLXr1wiDp0Tqmng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(1800799009)(186009)(451199024)(12101799020)(7696005)(478600001)(110136005)(38100700002)(55016003)(6506007)(82950400001)(7416002)(71200400001)(10290500003)(921005)(122000001)(82960400001)(52536014)(5660300002)(38070700005)(2906002)(33656002)(86362001)(8990500004)(316002)(8676002)(66556008)(41300700001)(64756008)(66446008)(76116006)(8936002)(66476007)(66946007)(26005)(4326008)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mhcta4AKeZd+D0pYQqzOue6cqdvdFmWGBNjLUaiys4iD8/H6xnTO0QUGbAwy?=
 =?us-ascii?Q?gdM7/F5GF6JAMU1vYISO/1GX6QD71wYqVn4GLvGeg9xuRwf83+U9JgUYSWPF?=
 =?us-ascii?Q?xQ5i683Mmt1G4ESqXn/m/Nsk4GUxWIRxImQgNbypZTdk6a/E6hYshfQxDqx2?=
 =?us-ascii?Q?tbJAWE2IeP310Z+hCQ6o/U1BpYzAKwteDIWo+wbUOsdvMYcI2hqDPGYuQy7J?=
 =?us-ascii?Q?JCfBWNJJQXSB9eWsud7ekiMXEWwZ6eBpdW/nL/nA93KNnb3r+kd9itEglVKM?=
 =?us-ascii?Q?BRdRh2SrFFpKZu6wymadO3k0Gmw7TYllKsSC7ANBz7vyul4e2ia9vAidNsT6?=
 =?us-ascii?Q?+RibAMds6K+fjn+dJKCDnAQ9G6cHUBjB1pRDtS+u+wyP6GE3cbk2zRbdGUXg?=
 =?us-ascii?Q?sj5rDkcL2w1JYfYzC7Ifct2/aBHFQTTy64TwWwdzXQUizGjLdnbMvc30xaiE?=
 =?us-ascii?Q?R+xOPXNstZCJ5OVW5ciHj7+VELbXqC9urmi1XRPzn0ztNiPkVcIZ5arq8iiB?=
 =?us-ascii?Q?fW+fWyPgmGxK8KaF41tEH+cv6B5yIjnZbH1O27Lgqq9fT4Ad8PPwhHatdaPg?=
 =?us-ascii?Q?bKIV1o7iVFyuSAz1pYxa/GXfHBFQKtXf1auxMfgjHBk3sz9IhkZVTmpkwmis?=
 =?us-ascii?Q?s+iNQZUU4dLEaJnABqQWm0F5IpEH2otI2ssBVHFOZVwrDnf38/RRwnDYWTaj?=
 =?us-ascii?Q?gv5nXYKjZgdOYBYTxHADlKGpSNnkXaadf7uwS4dsAvB4L3q1SVOsqRsh7Es+?=
 =?us-ascii?Q?PHtqPS8MjQdHRAbpTbXHcoYYcOa7aEx4ZoKxNpuS4I5ycWTLVpSW+7Hbjx9F?=
 =?us-ascii?Q?wNGP8boPGetCTNH9jTM40qlArh4dmZfs+rms73PEeAcNWNgXT/7TUlvCrIjA?=
 =?us-ascii?Q?VZdfFAifsgz5BKeaU5LeKBTBtvKQKS4F/hq0L6FzxF4RcJWf6RdFR/+uh46Y?=
 =?us-ascii?Q?e+CzBxWFweG2DLZOnIWWa875KdjGDRsTXtjgQoSWbX87sRHmnC6NabbuSxBk?=
 =?us-ascii?Q?eUk4vtNuHS19iwS1deztdGcjo+BYpBos7RGvCagTrIcbjkJPmBhVtMu7Q0Vq?=
 =?us-ascii?Q?3J77duKXyG3Mh0jGEfDHM6VdOv/GDt8QhbLCvJv233U7rvDr7DFqghuKGnSL?=
 =?us-ascii?Q?3482YcLtDLr2pgxGuP9hQ7kDNOeIFcTq8pzfTj9T3u1/rz9/C3HZk9MH7joE?=
 =?us-ascii?Q?2eDyN7PrEGDsebu+iRXA87GIAgWBReE/VX9quhTiNSUWiecg4+2q+5U0TP3t?=
 =?us-ascii?Q?ddhOwFjxY6unMxJs/ExS7+99Vq7/LVQ76nxohffLMafiamVx75JZNbPFvHaB?=
 =?us-ascii?Q?WGob1j6uk/kUvPGfkAMZfTaGYSXnQX7Ey313+R8TpG0TSdzvEV4/jS/mCg+e?=
 =?us-ascii?Q?NzzPNtTlqBVjEahGaK3KU/0EMZBSWk924/QeVDMNmEvfaiqqXrE1hMtkoZqc?=
 =?us-ascii?Q?rbSob+QgO5NNuZF+8aDv+r+ogBBOZcWOv7C6logBIUQmaH3whzDvoizGFbgs?=
 =?us-ascii?Q?Q9KrGHt4ReiLxHmo952fXyBxKloLVKop2azEZ8w4Nt30jtzP4Zg0J1SHTtyg?=
 =?us-ascii?Q?9FcNazRrZmpuWYNJ3DFHNjO6rYfiX3bpZfTeKK9kDkvSI60umlsUShBML6Xa?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b26c0a-5421-4a91-f2a6-08db9e15070f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 04:55:35.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80BrsyqwFm7Y8MoCrGOPkpp+zgngaWYLNIBY8ZKGB+RT2cj9U0Xl/hxZy7rW9+JOfdXlz0ZcHnhOqXBE9m6uNsVUwEgPpVIpXHi3seIQggU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, August 15, 2023 9:00 =
PM
>=20
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Tuesday, August 15, 2023 5:35 PM
> > > [...]
> > > For a Linux VM with a NVIDIA GPU running on Hyper-V, before the GPU d=
river
> > > is installed, hibernating the VM will trigger a panic: if the GPU dri=
ver
> > > is not installed and loaded, MSI-X/MSI is not enabled on the device, =
so
> > > pdev->dev.msi.data is NULL, and msi_lock_descs(&pdev->dev) causes the
> > > NULL pointer dereference. Fix this by checking pdev->dev.msi.data.
> >
> > Is the scenario here a little broader than just the NVIDIA GPU driver? =
 For
> > any virtual PCI device that is presented in the guest VM as a VMBus dev=
ice,
> > the driver might not be installed.  There could have been some initial
> > problem getting the driver installed, or it might have been manually
> > uninstalled later in the life of the VM.  Also the host might have resc=
inded
> > the virtual PCI device and added it back later, creating another opport=
unity
> > where the driver might not be loaded.  In any case, it seems like we co=
uld
> > have the VMBus aspects of the device setup, but not the driver for the
> > device.  This suspend/resume code in pci-hyperv.c is all about handling
> > the VMBus aspects of the device anyway.
>=20
> Good point! The bug also affects other PCI devices, e.g. if I unload mlx5=
_core
> and let the VM with a Mellanox VF NIC hibernate, I hit the same NULL
> pointer dereference.
>=20
> > Assuming my thinking is correct, is there some Hyper-V/VMBus setting
> > owned by the pci-hyperv.c driver that would be better to test here than
> > the low-level dev.msi.data pointer?  The MSI code rework that added
>=20
> IMO there is no easy and reliable way in Hyper-V/VMBus/pci-hyperv to
> tell if MSI/MSI-X is enabled for a PCI device. We can potentially track t=
he
> MSI/MSI-X irqs in hv_compose_msi_msg() and hv_irq_unmask(), but
> IMO that's not very easy and may be inaccurate.
>=20
> > the descriptor lock encapsulates the internals with appropriate accesso=
r
> > functions, and reaching in to directly test dev.msi.data violates that
> > encapsulation.
>=20
> I agree.
>=20
> Compared with:
> 	if (!pdev->dev.msi.data)
> 		return 0;
>=20
> I think it's better to use this:
>             if (!pdev->msi_enabled && !pdev->msix_enabled)
> 		return 0;
>=20
> pdev-> msix_enabled has been used in many drivers, e.g.
>=20
> "arch/x86/pci/xen.c": xen_pv_teardown_msi_irqs()
> "drivers/hid/intel-ish-hid/ipc/pci-ish.c": ish_probe()
> "drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c": pvrdma_intr0_handler()
> "drivers/scsi/vmw_pvscsi.c": pvscsi_probe()
> and more.
>=20
> So it looks like pdev-> msix_enabled is a legit and stable API.
> I'll post v2 with it. I'll update the changelog accordingly.
> Please let me know if you have concerns about it.

Sounds good.  I agree that what you propose is a better approach.

Michael

