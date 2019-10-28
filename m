Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94FE776D
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2019 18:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbfJ1RNn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Oct 2019 13:13:43 -0400
Received: from mail-eopbgr750120.outbound.protection.outlook.com ([40.107.75.120]:60930
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404084AbfJ1RNn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Oct 2019 13:13:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DejBMjT4I/P8E/QRkbyGxmaq1fcwbnA41euPAxvm1xyzJYraBWaIY7nHXsdJgi7EQ9Ji7rE0CE0amzUUEcHRAvv9KU63H4DvFpQpL+80RkIwHteL2GMZW7enyOtEvrh1MgCEKJHpdZOfinZOpTBvylQbpOLpDqfAlxBfLiP4c2tjHlPe/k3Di2/br680dAtfflWa5Gh3D4dR72IAZmqgeJhHBujwDE/Gh7A+Dk2LFj4AVfGLEgZP4+9noukpExiBNT0rWeGHd3jKFovcvOXdaI3v/r0ETwIvtay5oafdPmOrKMoJqutvHrQeT5l/PAbvz0JsjhuTxic0Cs/1faThgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsMvEHkd4wUe7tTgUP6ASC1CasjoW6tHlZufAUVyg+E=;
 b=Ju2d9I2mTCCtpwgmtTGypI852GHpDwGFZKUIrc28B07LuohLu2BjCbT4nVykZf/NctgVVe27VoMq0mylnZHF7eoXni5EjFi4ryPKIxVXxfvacyJvTkvZGd7DO5os659Qrr3cL6lRDaskFeBZTeZUCTBCckgFDFiqKKY9saMuKAvjFfdz4qkcgRVcXdcZ3qQnLSY1wKdLeiHgHofCEaFhbLYisULT6id55FVuSz+ImGiII+m7BSI1XqCCei/IRSrb23U7ivi0xlqdwm6wePYRyDrWQLtnJYuuRhITgnwIanZMjPIzvVnCX/7uha8m8/hJOpHh1vtRVxebJeUUufxO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsMvEHkd4wUe7tTgUP6ASC1CasjoW6tHlZufAUVyg+E=;
 b=AZy+yxIS5UamXiFG6W6TtG4LzAfGkzkCK2fP9vfnmP36mYWQuT4pedjeIkbfRMMrKmYhl6Y9DDm8llnwRvi/+E9KGiz50yCewcWZaQfRiQZ0zrMsa+ByIcId5xQCdsJ34PR3jrccwa9GS/bt88csOSuaw39lzSPGJfB3BpXXX4U=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0858.namprd21.prod.outlook.com (10.173.172.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.8; Mon, 28 Oct 2019 17:13:40 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9cc3:f167:bb63:799]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9cc3:f167:bb63:799%5]) with mapi id 15.20.2408.016; Mon, 28 Oct 2019
 17:13:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, vkuznets <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
Thread-Topic: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
Thread-Index: AQHVg0RIF4xP+GrFYUaioMALFqP6h6dbq8mAgBSm4wCAAAyGQA==
Date:   Mon, 28 Oct 2019 17:13:40 +0000
Message-ID: <DM5PR21MB0137A44A544F95F244CBAC9CD7660@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191015103502.13156-1-parri.andrea@gmail.com>
 <DM5PR21MB01377F713A553FCF721EF99DD7930@DM5PR21MB0137.namprd21.prod.outlook.com>
 <20191028162734.GI1554@sasha-vm>
In-Reply-To: <20191028162734.GI1554@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-28T17:13:37.9882423Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a82d85b-2f45-4c77-9da6-1ff770341b4b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [167.220.2.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fed338f-2736-459c-ec6f-08d75bca2de7
x-ms-traffictypediagnostic: DM5PR21MB0858:|DM5PR21MB0858:|DM5PR21MB0858:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0858BC50E200E58872C5E075D7660@DM5PR21MB0858.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(476003)(4744005)(5660300002)(81156014)(64756008)(66946007)(66556008)(66476007)(26005)(66446008)(446003)(76116006)(8990500004)(305945005)(229853002)(4326008)(11346002)(256004)(8676002)(74316002)(6246003)(186003)(6916009)(81166006)(2906002)(71200400001)(71190400001)(33656002)(10090500001)(52536014)(316002)(66066001)(10290500003)(478600001)(22452003)(86362001)(54906003)(3846002)(14454004)(6116002)(25786009)(486006)(7736002)(6436002)(6506007)(55016002)(9686003)(8936002)(76176011)(7416002)(99286004)(102836004)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0858;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zU2tu0nBPI32mRg8VE41P2XfpEdQUxsTGvPKpStZBNFWr1Q7mT8ryJFWoivUoao5VTXAQyEnBZepIPszEdlS45A9mPxixbDoYUb9+RPCDIAnXrDjT0G7xuOzTTpplq35q35zTwwMJwZczTDwq3r4mv1nk7rT77rnxNdyqqEjbq0TfGrua/Khk48mzPulbnhodmsNG6eMVMi2VAjLV6lOxd89uFbdDhotuJzGSRyO4xT1ebxlbZdYDQsPIc6TnjyeWp5FYckIx0dW3jMTUwvNheMbAEzXO0u6tky3e6/YjYXrd+NOYr+I496M5otE6IE5AJJpv/YjxwmeKNt1VzLiQexMJA5AYwOYsiydbAZemss0ndGNwhVpsbZBAdpdw8xWChL2N68kqXQDM19o3gOu8HpjOYeYiKSY79Nb0fZSC5eVpBNjU+zwFf0TnabKaRLr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fed338f-2736-459c-ec6f-08d75bca2de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 17:13:40.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Py0oC+Q7mnhazZguhBds3T0O0SzpfWtwfOhiKb0joIjycY8Yvwd11SG4MnQH2yM+y1If31WJv+6uw1PuT4H3nvHyGrh9f7K8HlbDzNBgsoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0858
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sasha Levin <sashal@kernel.org> Sent: Monday, October 28, 2019 9:28 A=
M
> On Tue, Oct 15, 2019 at 01:06:33PM +0000, Michael Kelley wrote:
> >From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 15, 2=
019 3:35 AM
> >>
> >> Michael reported that the x86/hyperv initialization code printed the
> >> following dmesg when running in a VM on Hyper-V:
> >>
> >>   [    0.000738] Booting paravirtualized kernel on bare hardware
> >>
> >> Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
> >> with this addition, the dmesg read:
> >>
> >>   [    0.000172] Booting paravirtualized kernel on Hyper-V
> >>
> >> Reported-by: Michael Kelley <mikelley@microsoft.com>
> >> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >
> >Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> Thomas, will you be taking this? Would you rather have me deal with the
> hyperv bits under arch/x86/?
>=20

Thomas has already pulled this one.  It's in Linus' tree.

Michael
