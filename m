Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3624FCC597
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Oct 2019 00:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfJDWFN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Oct 2019 18:05:13 -0400
Received: from mail-eopbgr680097.outbound.protection.outlook.com ([40.107.68.97]:60238
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfJDWFN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Oct 2019 18:05:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNRXurYIl1F2JyqOSUVK/U5deuHqIjiiqEPD1wjVRYEY2pZc/M54sgu/CY+53uZ6pOXOCqXkl9H4C+dWicHatKurwO14WENM+p5lhhk5QW07U0rYGx/IUdKsLl1nPj7fMq7z2dkJMOKQBRy4plXWfDIAJHQzb9UVk6MgSRjcHS6M8CWnPwD+Xm1lMOrDiTC0AfBgdKxiu2nPrPQgJtytE/IuugEVXDe5ccNNUYJ1PPh77LFkajzDyt9j8hHr2Wtd9VFyNZ8mwvDb1zt85twq+fm1CjKBxmUa4rvXdDqukB+93b+ApxCseqV5Njbmhqey9C113eQalnLcHfTd9y6PpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UDBt7Qzp0syHqHm2Zu0pva4HCXFwl94zBVw7QmzZ6k=;
 b=JOIvdpPZiHYuQBMqO/MoextSEipAW64Y1wWD9Ma3g5m+imlpy3+6BSpQyth8FiXshOcJ9v3Tn73ULFv7tfsxzx0sZeym6Fmq7h2vrfsMdVd016P39WBBJ0aBuqrVMO6tidaeDD7G3jFqL7WqLUfEnhl5tM83VXhKLXvhf0ED/oU3OlDCxgWZ9/hdSsjSB6M76T+3mhGQ82LRfOPUVt8s0A3jUqL+kbnDbNTDkE7XW5D0w0+6WYAFyqav22J04Kde9mHJifTK/Z/6cL7gtiejm2yjI1niNWY6IDJFtCuAKbJTh4QBJWoOMMXcoRahznAUdlvovZPbKfJoZfzmsiz1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UDBt7Qzp0syHqHm2Zu0pva4HCXFwl94zBVw7QmzZ6k=;
 b=eH8sATI7jLS+FEZ9coHMzeekRIRoDIEgoLrOsnlY2l8mX22afd5vzyC55wUROL2pQODl6nFpQ0jLuHf+TOP5aeBjqXInV1GBtbkejgKjYRTaiJhnxNvQ85SCbdBOaGZSSythNPfit0GcLFO2+W4hAi4AmyYY7OdjzT0KclCM3lg=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0698.namprd21.prod.outlook.com (10.175.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.11; Fri, 4 Oct 2019 22:05:09 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e%11]) with mapi id 15.20.2347.012; Fri, 4 Oct 2019
 22:05:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: RE: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
Thread-Topic: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
Thread-Index: AQHVegKONOQa53Lxu0KKenjrGuzu3adKtYUAgABS/GA=
Date:   Fri, 4 Oct 2019 22:05:09 +0000
Message-ID: <DM5PR21MB01371F96CD845743D9777DC5D79E0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com>
 <87k19k1mad.fsf@vitty.brq.redhat.com>
In-Reply-To: <87k19k1mad.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-04T22:05:08.2645000Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e41bfd43-9d57-441e-a34e-8737abbaa483;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [131.107.159.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ffdca8b-30c5-4018-6f98-08d74916ec55
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0698:|DM5PR21MB0698:|DM5PR21MB0698:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB06986E05276BB98156C223B5D79E0@DM5PR21MB0698.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(305945005)(6436002)(5660300002)(446003)(76116006)(6116002)(22452003)(478600001)(7736002)(66946007)(74316002)(10290500003)(2906002)(11346002)(66476007)(66556008)(64756008)(66446008)(33656002)(8990500004)(10090500001)(110136005)(316002)(186003)(6506007)(9686003)(26005)(102836004)(54906003)(55016002)(229853002)(7696005)(6246003)(71200400001)(2201001)(86362001)(71190400001)(256004)(14444005)(76176011)(52536014)(99286004)(14454004)(476003)(81166006)(486006)(2501003)(8676002)(81156014)(8936002)(7416002)(66066001)(3846002)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0698;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jSnYQmhtKgvCdNCJj8XlDoWznC0y++0dtHoRKcG1iMYzzU6rAT5mmLvmn9G0qISbmpSQBYLB5oTJjprSOhboSnF3wamXdFX/O6HnE7GWUtQjmHinYTTvnhmn72IhMa5kq/TJXat4rrBAwDUtHdYbsFyA6Bul/kencdS2HLPjC6AS5Pu9w8FSxI36eF4glw8YS/8CjRDwE3UwP1zjfhbybePj9SrfIy58BL66eb8e1agY2xN7D+3tGhm4Vm7D8h3WAwmPvwBO1WEvt/6y53Fm2eO+mu3huARHv3RYqQk6yJePZA99MeLYWKKYNbWDP8jK3IDqKxX/9qFMbscprzI+dmX3hTjlD6OFxSuATPK75NRchQhMnUVEc+Uwtcgzf7El2ytFRBXPbfpAEb3c7C/WKi4IInyjIph1i74IfagU0g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffdca8b-30c5-4018-6f98-08d74916ec55
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 22:05:09.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqLXvBqAXBBuwGx+knkdbxrne92ftP4bG/j4IyiRf6pVpdxp6AF88LqDGzDvi0DttoVuSdWHq8/EC32NVTV855jhvkpcNnxAxqzhbjLAtwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0698
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, October 4, 2019 =
9:57 AM
>=20
> Andrea Parri <parri.andrea@gmail.com> writes:
>=20
> > If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
> > HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
> > configuration version.  Bit 15 corresponds to the
> > AccessTscInvariantControls privilege.  If this privilege bit is set,
> > guests can access the HvSyntheticInvariantTscControl MSR: guests can
> > set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
> > After setting the synthetic MSR, CPUID will enumerate support for
> > InvariantTSC.
>=20
> I tried getting more information from TLFS but as of 5.0C this feature
> is not described there. I'm really interested in why this additional
> interface is needed, e.g. why can't Hyper-V just set InvariantTSC
> unconditionally when TSC scaling is supported?
>=20

Yes, this is very new functionality that is not yet available in a released
version of Hyper-V.  And as you know, the Hyper-V TLFS has gotten
woefully out-of-date. :-(

Your question is the same question I asked.   The reason given by
Hyper-V is to take the more cautious approach of not "automatically"
giving VMs an InvariantTSC due to updating the underlying Hyper-V
version.  Instead, guest VMs must have been explicitly coded to take
advantage of the new InvariantTSC feature.  It's not clear to me how
much of this caution is driven by Windows guests vs. Linux or FreeBSD
guests, but it is what it is.

Having to explicitly enable the InvariantTSC does give the Linux code
the opportunity to be a bit cleaner by doing things like not marking
the TSC as unstable when the InvariantTSC feature is present, and to
mark the TSC as reliable so we don't try to do TSC synchronization
(which Hyper-V does not want guests to try to do).

Michael
