Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D436A4E2
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Apr 2021 06:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhDYExw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 25 Apr 2021 00:53:52 -0400
Received: from mail-mw2nam10on2133.outbound.protection.outlook.com ([40.107.94.133]:11521
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229466AbhDYExw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 25 Apr 2021 00:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV1HNvBe628BEarKNQrbA/GBQFGkdUl7l71FIrcwPem/jYTWktlRFk0uBu6r4jIRDYvUPHJXTLEOGBgYhExEDjWYsoi9ryR00wvZtL7AxYy9J6fH9uecWadq0joNce2xWmH5jVVi/azZr2IUVvNkq4VUC1ebsS8nTV+ScaaN/QXAvV7RNHwnJ0SXlf7ZMuYoFQW5Dbi5O8D/Z3saLB30RphnIYWhb+7DKK+fA9bRDy70PxC3aQhjjTQt80Tbd4iK27QhQJ3cLsaiJMBMAlD4LWQcysr+WROEjBVge+jLjPY49ckz76CEeLUDLygohyrsRhdjvXlQOU5DlRP6AyNHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnFN3DFwybhEeUkpwG2qsytyEK1bpKhSPO52vgfAD1M=;
 b=XYjXjha0TlK8LbXaC35elvbK0AYsqCIM1rRm/8Kl5zINqu6T92vX+hhp0f1SeZN0rnrCVVNtzQb8LhZPbxOFZMYoHMAWhSRFiPF0rTVvsKJ3L3K+ajhVaGbStCfcbq6oy6OTAH5abfLT12DDurvAUtVE2Y9Kx5W9wqwtwFIq7kpERhpG+jOjseMjIeQXm2DAnT1knIB/57N8T6zJ99lVQcXyen1qJrr/3eHBVVeBRwdpMzy4ZV2y+zDSXKMPvL0HZMFW6YQXrMjjWYsgvzedIO2DDKllZumRSwHxI8cCPE6u3CYBOPzXZGfYF3pegJWtBgu3nKHoR3kNPV6Xq5oijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnFN3DFwybhEeUkpwG2qsytyEK1bpKhSPO52vgfAD1M=;
 b=DBagaqMbU9qMYKBrdZU9DMSJKHrEboZvp2/pRvU7W+UxVC0Vz6KLNV/72xzc2E4I5e7RxiPTJo8ivx9SEaYU4sQ6R8gm9BjLcr9kwc3pNNezBbyYq3GwnfSdzHw6hv9rZrulOQXx+F3NBdAK6kHuLp+aNwN47u212vCRVvyRbIE=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by SJ0PR21MB1936.namprd21.prod.outlook.com (2603:10b6:a03:297::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.2; Sun, 25 Apr
 2021 04:53:11 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.021; Sun, 25 Apr 2021
 04:53:10 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXNzrFBLwYwYTj8kqzheBKY3VooKrBsNwAgAC786CAAAVKAIAAAe5AgAIRr4CAAClZ8A==
Date:   Sun, 25 Apr 2021 04:53:10 +0000
Message-ID: <BYAPR21MB1271A51781DB2553FBFEAAA9CE439@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB1271F9B76FAA423D7BE6DDEECE459@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MW2PR2101MB0892D7E83CC44D97F4317871BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB12710349DACC3FF32CC65793CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MW2PR2101MB0892411250C6BB554DFF38D3BF439@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0892411250C6BB554DFF38D3BF439@MW2PR2101MB0892.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825368ff-303b-448a-ba43-6f3872c68267;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T06:58:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3812403-0725-4a36-f71f-08d907a606bd
x-ms-traffictypediagnostic: SJ0PR21MB1936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR21MB1936D23FB97F486EFF727200CE439@SJ0PR21MB1936.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roRRh/FxhmXLcD3B0aXHV6J1S7lWkg0WQqL160NMDipZ8yg/8FFf0SJarJEDqXXI2rImBPcXoeEdkxOCStdSKLg/gQqg6oMXbbFGFJsjD8i2FPXl0cfWyDbbjyyMlPWVL4uwMrzIl8gMDfQD8UB936e60AEh3Af4702hghpJBbF7HuRdhFlpmgGZr7OvbUaxL2RZXmFgV6oj0ZRyL28AJI8KyhitfFRXFrA9zikfxZYNNP8wBsz5zEeN4TCJn5XiAvbx0E0YTX2iz+B/AU6bAvxAzPMCvnNnkGx030A68E716l0TYWvr7r3fLRw9CqEv3wW+c45GIuzFTwHF/4dUGmSxJlVY1uSkPhPpN6SZCgQoMyy5ngN8oKM19equzO0h8+XXzeK1yQkJ5Az3cLvzJY8lwyjXw1p4LUCL36KMSrEXgDmHFKTA67s6CDzfoeQdC5VS7IX5CojheivcRk99qHlVpzfLE8a177NhXDMYJyE2IsiGh3cB2lZBlhg7gtwozgN17NBj2a3q8HYfPbGwBJcQ2lqacsNCmFd8Cth9IWYFk6n99GMvK4CHGVRzaW6ymghWc+Ps7u3yYjxKuZ85w/E95fXsJhUpblndylyQcCyxGjJOClVeNVR+Zj8mBhtdN8S7WS++0/B8TDJojpKVRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(64756008)(66446008)(66946007)(86362001)(66556008)(110136005)(33656002)(38100700002)(66476007)(8676002)(921005)(71200400001)(5660300002)(53546011)(82960400001)(76116006)(6506007)(26005)(7696005)(55016002)(82950400001)(316002)(8990500004)(2906002)(122000001)(8936002)(83380400001)(478600001)(52536014)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9zQkSG1l0gpz35HO+gr44MrIiKeutzt3HbBBCHuPvyj/zxEk5Xas1TZ2/I0x?=
 =?us-ascii?Q?vDop41/PAZANJwydhaWwpRwqaDvEJI+u9bteLSVWim1zVA78nfHUqT/VR9zX?=
 =?us-ascii?Q?ajEY9qTyjpzRzOESxPTS4v2gVgAzMghb5TM0MxJXpJ1AeA2OgEUo/EjSLRca?=
 =?us-ascii?Q?UX9zz0srnMq954aqnzalHeq7hxNLK2wgA7NaEFBNDAjqAR5uUSz/WTwOvoHL?=
 =?us-ascii?Q?VZk94Q99xc5hOEdEt2WMeqHSNuGUqb2Z3WICfKfM5CIEzu06ozAujkiWPw4z?=
 =?us-ascii?Q?1RMPUhIbht/b9N36n3I8la27N6Q9fyKtmiriG0HrLwo10dhf6pIbfg6/JIDc?=
 =?us-ascii?Q?zn2/oMqNodCzAmDv4cXEEIEizweVDs5cJst4V7hSYV3AIZLl2/dG/sm8ZaDx?=
 =?us-ascii?Q?EncJtBaoyz/pdKoX8UElT77pq6hadeFfRSPDrAZ6QjUn+3YYmYhNaFTjP71C?=
 =?us-ascii?Q?1s5B40djn91Bp5rJ9ZTdZQkpkvU9T8QJ7hqJnG7+xweRBKH8m+v5hO4Bayzr?=
 =?us-ascii?Q?dZjrz095s0FUlynt5zmn944Bv1j8EpNcgjqhRbN0RFxXaX+z8UN/pC163RpC?=
 =?us-ascii?Q?pEN9tvWxz7XZY/IWgJY2MVJ/bNpRmFLhRm8TUcLSHmGY2kCxn8H1fDppEMJI?=
 =?us-ascii?Q?OBcAcs3Fi/ixxC2Wu+8FwI1mKzKKDXHZU0sP5LpP6N7qY5kcR/vbBxmPHWLI?=
 =?us-ascii?Q?WLAJUJ4FIMBBkt8Xyrf6Y24pRXAOA41ELZGaAnePtmssV3NwtElgGrce5G/7?=
 =?us-ascii?Q?qdG/C/slHcVH3GuOT/TiCyC8MFgI+VWKs7CL/kQ5E894oc/GsJLDgMSAvSK2?=
 =?us-ascii?Q?dKhnjNOTlq/Nf+QvmUDDtEaN+n7D8Y8CkvIlBGWeJMeTZh1tCoQwVIoE38dc?=
 =?us-ascii?Q?jR+WkxdQvy6JK3BxUURLHs3HM+7Q7OGo0wxYVWxJJXxfQKcbYVQ464bxoM7o?=
 =?us-ascii?Q?NGxXuhtYXb0FEJDPBqai4hzSMZjE1hzkCcmFvMGSODqrsq2A71/ORwER0m0H?=
 =?us-ascii?Q?QE59tdoyTjkrrKpDkC/btp2EjT1aYnCg/c8I1L6BO6uLS7+aPwk82Jlxxf28?=
 =?us-ascii?Q?rrS2S23ShJMuOpZA2FLsvo+RK0vcozcKjK+Ubvr9w05E7imDP9UmlMHMGqXt?=
 =?us-ascii?Q?S0zVCWy/BQO9JF5dJdqSyC3a7VabKwbMpnED9/q5BYV41ekmClpLKM2GJRID?=
 =?us-ascii?Q?qKRVPMJ2Hf9jHJAY7s1J8vRzuDHlGRw+pTz2TEOLJuik48/6ZO2rXhUG1Uoj?=
 =?us-ascii?Q?4RGxuusNI28+GcknslhSHSjY8Q0g+EVCfVaedQOJqrks3gQwZMJvQ48EaVpr?=
 =?us-ascii?Q?uNU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3812403-0725-4a36-f71f-08d907a606bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 04:53:10.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /STaEHfhZFh9XEQLj2gB1PNt4ViBXY8ZZiGzBWTF8zZ0NLZzCReYA+XBwlTKZMAo23hYVLy41nyo8oyqNxrWqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1936
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing t=
he
> device
>=20
> > From: Long Li <longli@microsoft.com>
> > Sent: Friday, April 23, 2021 11:49 AM
> > To: Dexuan Cui <decui@microsoft.com>; longli@linuxonhyperv.com; KY
> >
> > > Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when
> > > removing the device
> > >
> > > > From: Long Li <longli@microsoft.com>
> > > > Sent: Friday, April 23, 2021 11:32 AM
> > > > > ...
> > > > > If we test "rmmod pci-hyperv", I suspect the warning will be prin=
ted:
> > > > > hv_pci_remove() -> hv_pci_bus_exit() ->
> hv_pci_start_relations_work():
> > > >
> > > > In most case, it will not print anything.
> > >
> > > If I read the code correctly, I think the warning is printed _every
> > > time_ we unload pci-hyperv.
> >
> > Okay I see what you mean. I'll remove this message.
>=20
> Here we just want to avoid the message every time the pci-hyperv driver i=
s
> unloaded. We might want to see the possible message when the PCI device
> is removed, but it's ok to me if the message is unconditionally removed.
>=20
> The real issus with the patch is that the 'hpdev' struct is never freed w=
hen
> the driver is unloaded: if we print out the value of the ref counter in
> put_pcichild(), we would notice that the ref counter is still two when th=
e
> driver is unloaded, i.e. memory leak occurs.
>=20
> Before the patch, hv_pci_remove() calls hv_pci_bus_exit() ->
> hv_pci_start_relations_work(), and the ref counter drops to zero in
> pci_devices_present_work() due to the two calls of put_pcichild().
>=20
> With the patch, when the driver is unloaded, pci_devices_present_work() i=
s
> not scheduled, hence the ref counter doesn't drop to zero.

Yes, I also see the leak, thanks to this warning message. Those will get fi=
xed in v3.
