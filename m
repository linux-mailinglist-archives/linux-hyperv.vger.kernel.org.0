Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0B36786F
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Apr 2021 06:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhDVEUT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Apr 2021 00:20:19 -0400
Received: from mail-mw2nam12on2115.outbound.protection.outlook.com ([40.107.244.115]:51136
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhDVEUT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Apr 2021 00:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxjRB38fsR2Za+pmGs8cQUPTZFaySnjqG/rraxJMpq4afW3JCvMDXeEDvUhKAcwVCeu0gA6M1RdmYWf2nZ71ftfWM8NTiLVjwq4Psuw2nYE5QnSj5Jm8c7vMYI4UXY94DNjn4h8nLQX5G5ux8rfugrs/CfVV1ugTU+CDdc0G9R0JXbwT5MrrIBxf/sSrm1QDNW/iel3J2YIOR+r9vumbldOdDq82/WA1wtUyXf6M7kQ3yPVdS8h11jdQORiwa4arGZjBFlagNa6NfeS+wHuKlHmRgSWU9k08NKU0kUCPbd8Yl06bfn2VLe6R71SBO12pVBwBTJGW6qK5NkgYvQqwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoCZvqmYY/eMpd91HuBHJhHZPl9aBciYpSqJdOZGF5E=;
 b=AKGjyw0b5wB+MZSBypEMgij5CaGK4PTmXI3KAPfJhT7p3XcExcgo2SrZ8aBTN65btio/WTZKLeU88O/sWdlwX4zVaSQKatgr0DAu+qUxh/ebklrhhO3TnfjlFPxUCuDi0qUZUQqtPDgQMnPreyaMYi3LFsiRS16Vdm3yd4zsJaV1RLRYYaW0CW2qBx7H1Z1m/BhSMYOZdujgTmTHTXU46z/B1F/Mr4RJsgaLvEZcTiNCvTG6hxVLAzoKT6zykEZnnZ8+Xuofq3NDaqR/TLM4h9iwkUEgjh44FYEm5FmJdCtthh52XfwgX/IyqDvp6RG+N8XCzu+4VgVaL18iUy8kPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoCZvqmYY/eMpd91HuBHJhHZPl9aBciYpSqJdOZGF5E=;
 b=E3/9OCc1QiBUXpkLo5e9/EsFB69RBmgGir1Nn0yx+qrAjRMhQlFrqOabVAJfb/oLkwYz/V/KFzKspqfWrOVekr5ggIBEzM/ITCehmzMb0vMv4CZRpD4uzYsF7Zi756xiK1hMzHnVk1yy8fxHyhbjJpoAODj2ej6t76ic5BpaNdI=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by BYAPR21MB1224.namprd21.prod.outlook.com (2603:10b6:a03:10a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5; Thu, 22 Apr
 2021 04:19:43 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.016; Thu, 22 Apr 2021
 04:19:43 +0000
From:   Long Li <longli@microsoft.com>
To:     Long Li <longli@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AQHXNVHkJ0PNV1hvE0ut3i0wELJaQKq/Pj6AgAAGzVCAADSDAIAAWvqAgAAWNYCAAAcrEA==
Date:   Thu, 22 Apr 2021 04:19:43 +0000
Message-ID: <BYAPR21MB12715D359C671A7B176D12DFCE469@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BYAPR21MB12711AF8B782FAA4B492D0CFCE479@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MWHPR21MB15933F28861A2C448C3F233DD7479@MWHPR21MB1593.namprd21.prod.outlook.com>
 <MW2PR2101MB0892B264810E6E6E54A96C4DBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB12718D0364930BACC703F659CE469@BYAPR21MB1271.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB12718D0364930BACC703F659CE469@BYAPR21MB1271.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ae65fefe-c764-4af1-cee3-08d90545dad7
x-ms-traffictypediagnostic: BYAPR21MB1224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB12248F93A26E95490479206ECE469@BYAPR21MB1224.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llJ0g1t4O/vU9VzjWpqZcEp9fgZrLtlBPdS5hR+SgW7GGftVBu8WL90k2i7f2npc8z8Os4s7coCZME7qSmiAlPDw+n614IY9zrpwXs0/tBsSuHpT/5WN6H6bMUN+5lZPkTQlAhmc6+3PRZ/mUr8oVC4rsbH5V5SmPj0MT4lQZabbzYgeG4BK77hN6xQVjLIL7/YC1VArWRIKGWW4uEUFOgyYuvxxcM7yXx3dcBy92yTlovspF23yjtNoWhLdlIHQohnHHVLCAO8eRvdDf6JSDLVb4P7Wkf9oXqicyOXWllUUuQTYqvVInu1/dsLNyYjSN+9IJ8HYC49q+1Cv7YyNMk5Bu9idAGyWy/wiRoYklVxWx0LkKipBDe6QtLw10rL2fLg5xWVpT/okLEAzBBXsgFLcxo4M+Je10cb0kEJW2Udf7XH8tb5phbtL0JzWh0dRgXmC265A5p30ZR5+MX4IKOYZFJUUZVX3uJEE7XthOlB7C9DzgaY6xlpNxO4tsp3ILUVaH13Wy8TEBFgm8x4xTGYEVZWEuTMudhZb6KMCNN7etC/qdqRFbXiZV4aOk3f0L4vTbmVEe2VsZD+SrDu+gvo/ag7KE5J2m9GBgYpM9lg1jsJs9jle60Feg9hqwPpj3aW5Wup/gI1R0tKQFUcF/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(86362001)(66556008)(64756008)(55016002)(66446008)(66476007)(76116006)(316002)(26005)(6506007)(82950400001)(9686003)(66946007)(2906002)(10290500003)(8936002)(186003)(33656002)(921005)(82960400001)(2940100002)(52536014)(71200400001)(122000001)(5660300002)(38100700002)(8990500004)(478600001)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pj+Rv7IF8ol9pXdIvlKlrr6tWZcNaVo7h+rCDHSu4jAZkpMf3C3iHGQXxT7U?=
 =?us-ascii?Q?kVTCKJAEaAoDuuvnFa8hZBM2nYJ9t57O+e+yV1kobITQAvFFEkUWTg3fB+O1?=
 =?us-ascii?Q?39/O3htyBHbcd14T2c0SEAsw8uajFUOoBlQfEYQdQeFH+D3AP/CGXP2jtTMV?=
 =?us-ascii?Q?TUk+5jyuoLvxkxho+E3+0wmRXzEs5Npki+jPjYTNd2QUMglwDSrpGxAQO//6?=
 =?us-ascii?Q?bjrJATtNxlsm0NFyuSqiCVg0RZ7KUFJ+aREYNRIOBm4IuEXI50vd65W6HJN1?=
 =?us-ascii?Q?cu8EBGnnAmWE3+sd+7UN8Wv7hoRkAjxtWhh9k9qkw5Tvu3pHaSnpAjiYnM33?=
 =?us-ascii?Q?9D/no+rFCFnE6MgRbffUlQ9tZ14PBU9LSMh0Li9dgFYcmnzATJLwvCisT/i4?=
 =?us-ascii?Q?ssMI0i6D9NByVQDi5W0o2kwlDhnqHXkKb2crlH/YhmWZruEiGkzbvRJ4rL1k?=
 =?us-ascii?Q?TGzod2rJ5bdn710nJ9x9IY+DCHjyd2k9yl4qlF9aUUQT2yrDbeaA44U1iha2?=
 =?us-ascii?Q?h4BJ9QngkPfAwht/b20JRFxhKgs+hANtmJVlFN/151GEdKnec48x4LtSulpq?=
 =?us-ascii?Q?lSWa4tRA90aTKG3Rqgc4WnmqgSEdz170lyqgZwydckrylHlNiqrOCSDkzAQs?=
 =?us-ascii?Q?06P2oQlf6jjEyqQoLXr1QT8Hwkh36FjOX1thdwj8wdX48bOv7Mik3owcfwnE?=
 =?us-ascii?Q?f9a5e3DjroB3/4oy/01Zw3pSDD4tWCMiPjI8Xw78RLXNv2SfyTysb5hIc1QY?=
 =?us-ascii?Q?HMZXnwToW6BuNrwDhVyFqMqv4zwx1zhWBixCtou9zL3FmOoh6gr60dkyvCj5?=
 =?us-ascii?Q?cCMYVcWFAfQLq1ssKSJvinX645b+dNUaus+YeqJtiws6Yk5C+k8xWOipgYz6?=
 =?us-ascii?Q?F8WEh+zHJ6mZMQwVegFybWC5g5CPxk6yxsEjS0ztPyGJAXoOvVMTL3yb+6Ti?=
 =?us-ascii?Q?JshYgx5BYoheuWB5QYI4L25gEBpa5Qe8yK0vmLPhhuX2VuFai0Li7vwRR+SS?=
 =?us-ascii?Q?1GiBqU++lC9u4857EkLpM6LKkLBIVEzqNxPRYQKxxkNC/DzNyjRc/s8ZZfQj?=
 =?us-ascii?Q?e/BNK0csbcA0G4qfgObnJcPNYN/wlVxFZSqlmQdrbWZFUP1v91a1UE6sIQDB?=
 =?us-ascii?Q?8ExSwNgCwI2iavPeW5f3F0vvdtIHHUtnN9LW1l1Go5kbdiRr+ZXmUWaxRENo?=
 =?us-ascii?Q?tvEwKamDSg/qSA0kyDjNU5MOih8u6JyFtnFNNSi8Gzmb2hahxGiOfP83edjz?=
 =?us-ascii?Q?xtOHqWfZ6/yr+da6HL0PENI1CCg6WKvfNLKM4WE+j+CTkY9nAp+6q5ZkMaob?=
 =?us-ascii?Q?FQo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae65fefe-c764-4af1-cee3-08d90545dad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 04:19:43.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDoaeU/WML9pp5AWANioo+1/NxrsVD/CUEn8oDN7B0a4MN7xQaxNgq+uOh5KgRiecTo45vDFXop1fGk2og2QOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1224
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the devi=
ce
>=20
> > Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the
> > device
> >
> > > From: Michael Kelley <mikelley@microsoft.com>
> > > Sent: Wednesday, April 21, 2021 2:06 PM  ...
> > > > Yes I think put_hvpcibus() and get_hvpcibus() can be removed, as
> > > > we have changed to use a dedicated workqueue for hbus since they
> > > > were introduced.
> > > >
> > > > But we still need to call tasklet_disable/enable() the same way
> > > > hv_pci_suspend() does, the
> > > > reason is that we need to protect hbus->state. This value needs to
> > > > be
> > > consistent for the
> > > > driver. For example, a CPU may decide to schedule a work on a work
> > > > queue
> > > that we just
> > > > flushed or destroyed, by reading the wrong hbus->state.
> > > >
> > >
> > > Yes, I would agree the tasklet disable/enable are needed, especially
> > > since
> > > tasklet_disable()
> > > is what ensures that the tasklet is not currently running.
> > >
> > > If the hbus ref counting isn't needed any longer, I would strongly
> > > recommend adding a patch to the series that removes it.  This
> > > synchronization stuff is hard enough to understand and reason about;
> > > having a leftover mechanism that doesn't really do anything useful
> > > makes it nearly impossible. :-)
> > >
> > > Dexuan -- I'm hoping you can take a look as well and see if you agree=
.
> > >
> > > Michael
> >
> > I also think we can remove the reference counting.
> >
> > But it looks like there is still race in hv_pci_remove() even with
> > Long's
> > patch: in hv_pci_remove(), we disable the tasklet, change hbus->state
> > to hv_pcibus_removing, re-enable the tasklet and flush hbus->wq, and
> > set
> > hbus->state to hv_pcibus_removed -- what if the channel callback runs
> > again? -- now hbus->state is no longer hv_pcibus_removing, so
> > hv_pci_devices_present() -> hv_pci_start_relations_work() and
> > hv_pci_eject_device() can still add new work items to hbus->wq, and
> > the new work items may race with the vmbus_close().
>=20
> Good catch, adding a check for hv_pcibus_removed should fix it. I'm sendi=
ng
> a v2.

I don't see the reason why we want to assign hbus->state to hv_pcibus_remov=
ed at all, so just removing it will take care of the race.

>=20
> >
> > It looks like we should remove the state hv_pcibus_removed?
> >
> > Thanks,
> > -- Dexuan

