Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55521367822
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Apr 2021 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhDVD55 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 23:57:57 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:35975
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229536AbhDVD54 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 23:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2k5k3QqCyXtJer9VCAA20tD72OuAdKHmC++P2nEVpjknIPvYl1gPqjoJ1MzAVwdiEWPuC4UHC0UDTJdYcnC+yF0DTu5HZiyqw7V+PhGl7jHho4SYmpFOF8EuqbNc8jWdKm/xhJxxw2pDN9/NOd62fXlNv/xH1f6uLZUCJN9Z4dAi9iHxRvP3AJc5Mys5XHhV5Y6kAr7dB6ttvJO/SBbPEvkm488tzhmvk25mrM38AMC0Pu7VpzDS2c5Yr8+tNyQPlRB7n+Bsyl5kPnAjMVjSCjVg8XJDJ2jhoSKO/B9r3NmeEG6CSviJq5qHDSVDYeB7R7dbZF1t4q9J0YXxwS7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2FSsfPVnYqnjzuwvKob6xukRN9GM/eScekqAyapkMQ=;
 b=LNBYWn/mRwOExoW3/ysgveIBRQ3NpaQkFC9DCP4nU3/o5g8Gz9jq+tJzCUNEfh971E/2zvDW/l+EYUbCr8o4gOYx3GmExOpcvfLAvDQtRPW/I0t5FGGY+BUJDRV0gXoe76FfXZDw94webATEwYnmIn8HkStBFRLqJzqDRekc166LHUWRUTqKLUAZAcpRHbFQSqSlz0Wq0hpmiBvAWYF+Ht60Nwtny8qiueNSonmrH8jWc3ZZw04PkY1u3JAECFDiuXVeLCixJF0EH50CR5YGhTqjAvOpPYJyJTsAb9KewhqYMfUwBLaTYEeQ7jHJTZD0jgsozEjAQ2Ro6A4FlHLUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2FSsfPVnYqnjzuwvKob6xukRN9GM/eScekqAyapkMQ=;
 b=FNYFD82kTbYpp2C/qjR3CAHS1TtJZHAVWfbnL46KZ2IZq1frZ8hVIWaeuz9aliaFWkvda78pj0UTVLm/+ZxO0pxJyTGbWZfUjMGe/YMLYL8CPdeTR5eBmnGqhF2exD0/LVJR7CRqHddILFrnQRimn6lm/xEp6AS74nmEnqzzmGU=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by BYAPR21MB1317.namprd21.prod.outlook.com (2603:10b6:a03:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5; Thu, 22 Apr
 2021 03:57:21 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.016; Thu, 22 Apr 2021
 03:57:21 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Topic: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Index: AQHXNVHkJ0PNV1hvE0ut3i0wELJaQKq/Pj6AgAAGzVCAADSDAIAAWvqAgAAWNYA=
Date:   Thu, 22 Apr 2021 03:57:20 +0000
Message-ID: <BYAPR21MB12718D0364930BACC703F659CE469@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BYAPR21MB12711AF8B782FAA4B492D0CFCE479@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MWHPR21MB15933F28861A2C448C3F233DD7479@MWHPR21MB1593.namprd21.prod.outlook.com>
 <MW2PR2101MB0892B264810E6E6E54A96C4DBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0892B264810E6E6E54A96C4DBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c2cd82d-a9ce-4184-9a5b-6c1855cc9093;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-21T17:24:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4416756f-d768-4c2c-bc5b-08d90542baf4
x-ms-traffictypediagnostic: BYAPR21MB1317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1317A8C7D5C0C9188C46880ECE469@BYAPR21MB1317.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nn8wvK8xW7ceS87vlHGQovir7FrDPAR7so/TmUcuMAMhiFKJj8H6zElm7q1euaI3Pd2IMhZD63C8fsd8cxtekWdoHeY6DC3qsdLWVbb8bJrvEHCp2mhCrVcMvGjyKnawqNF/++CHg65uM+lHVPp+wK60ezci74q1a2UIMkQrLZ5y/JkcNzI1YhDn9doioFZIUwBYR/KAXrJ3cGzEIONom436cCff6cCIJtN/VvQbpKywbxOJMMXsWzaMmlyTpPg3DCPL83it7db88+8mGG0ttom7Tz6xw3Vv26JgSHSPIjeX4Tk27MdiFvqjqrpYk4oobmRtj3XJnj8m4voFeV+Xwvq8QDzg+3JWCD6fvFjI5xDdLs/eDBe/X0DI8PRFrnsxZWjR/GORYzKyTqOY+slDLlt03vfYLl5plP7WYnr/2Zzyzwh8LW9Mup2J2VvEB9jIrZAfId7Cjv3QbLrj8g7lBM8z5fbByiylL6GGmkrxIV9AckEEQJ9wvAzx11iKCymtDW+ib1fsjq+hRf0KhElddP8vXKyLmRUK9VRvyaea9jt5ybDmyBMpAB9IHhtsV8qPyaqgJkqZAkhmj/2RhMWGBjjwvdz30vdkqLtB/WS5+Jw2WahCx0P0y2G4TLiMl3dV1rpiPTbP1BhRUkh1alahrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82950400001)(316002)(66476007)(5660300002)(110136005)(86362001)(71200400001)(186003)(8990500004)(26005)(8936002)(2906002)(55016002)(82960400001)(76116006)(33656002)(6506007)(52536014)(478600001)(10290500003)(66946007)(38100700002)(9686003)(66556008)(66446008)(64756008)(8676002)(7696005)(921005)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L4WoSyz8zfo62WhrrMIJIymoncI6u593inSDYLaJzjQfE8EqHKaP84tVwqr+?=
 =?us-ascii?Q?d0VvuKV9MqKnMkDUgoGHjeSu+wzHG7zTWArh0TJXOTdGhOM0SbMKrV663RAc?=
 =?us-ascii?Q?3aoP33LkaDrFmM9vVX4UqXVfp9uGBZITg8/HMuyRmZYSJ+yh6BQDIlKzyCDM?=
 =?us-ascii?Q?P16i8n+A/QJ3vfpYijFyZlK1sls6D/tb9ABF2sFtj3CJZ8N7S+RjUWbeRtbR?=
 =?us-ascii?Q?wQ0h6Zu+YQaMSDOPrnc2K/0bQzoORS/gENqRiEYsI3066UTd54SsYhZ0e3Xr?=
 =?us-ascii?Q?t7fZ3PbN2Q6GwGfy4z1Cqe5/ywabHr8CvSYe9ohGetUV7GU+yX2DQ56hItAL?=
 =?us-ascii?Q?qyHSkcNx5ngXXBcyduJUFq3sVeGgdqh5hgB3pgpl0jajsYJoWNhccQk8us7z?=
 =?us-ascii?Q?3fKTZvugxIQKBRLAbknKgx/jaeXlr9RB/vImsWKDYmeNwHCAyPInTTQFSyqW?=
 =?us-ascii?Q?mTsmZWRql/Bg0ErcAa2Iaf6s7V/XjYDTJLgeyE9XHBWQS5W5PO6N9T+B6KIN?=
 =?us-ascii?Q?HL8xzrCl81MsVAphL7mxVzVv18E47VKXQy+V4K3gOKN35RJQwtqXWJWDW/GM?=
 =?us-ascii?Q?ZkgU3CKeTA56yZ0F819fcS/0qOQw2HRzok1+IivjhKE5j1+NPfS8UPd9DU4Z?=
 =?us-ascii?Q?DFvZKltIsM0NE71A3ucBMDUQtaLNk7qweQfFgoM5cgZjyqH380/6ccjLm9FC?=
 =?us-ascii?Q?h0Q5lRSlC3cJ0l2xq9LkoIwwPq3/HjoUL5jBDeAHz69f1U2MWMyOk+57nxDh?=
 =?us-ascii?Q?mb9aTp3/mwKnKOuE+qF6ZTC16r/p+HuJwuY/RNLXKAjTosNq0/Zb35oq5lm+?=
 =?us-ascii?Q?R2vNDR1ZWjNHRr6Ps6aEkITgGXyoGRUH00HZsVOIszn7scvTevIkZXkvhaUR?=
 =?us-ascii?Q?vAYdtHb2UdfZjUGvDx7j3wQLZf7zjJQ5cb9rhO7m/Gsx0ByHNwDr/R5sFG6F?=
 =?us-ascii?Q?4cgHmh1QVEyVs+y2fMDxGgm290bevSJ/5XaEdh29leDbWnE/gDaonq8tChIM?=
 =?us-ascii?Q?PstetQZ5Xx1CtWNoXfKlqx4oSm/yieiSXVxc5WqjbNbpxUqJ6l4Wik6yUqPB?=
 =?us-ascii?Q?9iqcm8+bSZ5/B0GJbni5H+O33kOUT0Gnf8xr4UtSGyxK+M6GWy62Y7YyD+j1?=
 =?us-ascii?Q?Af1ij4rUYKFzL77NHk8N526+wFIPyYqW4wuDl13CW/nxgg2p8i61ys+LF/8M?=
 =?us-ascii?Q?i4EVXJeDstqA8D8T1GWeGIx/UDM/sLusbA7uq9GFTDPqO4LFBt9oTRxsxzf4?=
 =?us-ascii?Q?S4zGctAPQFl/rmpcRQwVjlgXq8wkEOvlJGFQ7DaOOFDBp2G+tZp0EiZ84PxH?=
 =?us-ascii?Q?GrM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4416756f-d768-4c2c-bc5b-08d90542baf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 03:57:20.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 422uyMdfiDsCRdebQ0ILehxTF22KkLHokniF6cKH10lWgdabRFrQ9KnhWGOeV14uP/uJU5NWHHGXGd7o01H6DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1317
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the devi=
ce
>=20
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Wednesday, April 21, 2021 2:06 PM  ...
> > > Yes I think put_hvpcibus() and get_hvpcibus() can be removed, as we
> > > have changed to use a dedicated workqueue for hbus since they were
> > > introduced.
> > >
> > > But we still need to call tasklet_disable/enable() the same way
> > > hv_pci_suspend() does, the
> > > reason is that we need to protect hbus->state. This value needs to
> > > be
> > consistent for the
> > > driver. For example, a CPU may decide to schedule a work on a work
> > > queue
> > that we just
> > > flushed or destroyed, by reading the wrong hbus->state.
> > >
> >
> > Yes, I would agree the tasklet disable/enable are needed, especially
> > since
> > tasklet_disable()
> > is what ensures that the tasklet is not currently running.
> >
> > If the hbus ref counting isn't needed any longer, I would strongly
> > recommend adding a patch to the series that removes it.  This
> > synchronization stuff is hard enough to understand and reason about;
> > having a leftover mechanism that doesn't really do anything useful
> > makes it nearly impossible. :-)
> >
> > Dexuan -- I'm hoping you can take a look as well and see if you agree.
> >
> > Michael
>=20
> I also think we can remove the reference counting.
>=20
> But it looks like there is still race in hv_pci_remove() even with Long's
> patch: in hv_pci_remove(), we disable the tasklet, change hbus->state to
> hv_pcibus_removing, re-enable the tasklet and flush hbus->wq, and set
> hbus->state to hv_pcibus_removed -- what if the channel callback runs
> again? -- now hbus->state is no longer hv_pcibus_removing, so
> hv_pci_devices_present() -> hv_pci_start_relations_work() and
> hv_pci_eject_device() can still add new work items to hbus->wq, and the
> new work items may race with the vmbus_close().

Good catch, adding a check for hv_pcibus_removed should fix it. I'm sending=
 a v2.

>=20
> It looks like we should remove the state hv_pcibus_removed?
>=20
> Thanks,
> -- Dexuan

