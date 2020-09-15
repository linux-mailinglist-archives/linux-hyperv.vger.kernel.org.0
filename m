Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1F26AD82
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIOTXC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 15:23:02 -0400
Received: from mail-bn8nam11on2119.outbound.protection.outlook.com ([40.107.236.119]:32928
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbgIOTWl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 15:22:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5Y3xXe4iaPhW6GhrNK/QhD6NAgIdqVuqcqVG+BgswXBjum7INZM+QxTeH/YqGH9lxdr/wuk6T2FcsvX1E6auCFkBpBMDKVRoMFZ/KSMeLGVrA6Vl9gmPJXRWEXtU2GusaqpxisAgRqX/WCKsoZNXrTpXnfQvntPrwiZ8Bz/vfndf7pp+iwsTDVIXaRtNk6oMj7JGIa0/dSzcbgW+Nr+rwT8yo62ZIWoAZOjwHjwx76jUKF916OneW+LcD3e8kQG7LsZN62fuYGSOzIlXN7SgYTloMpHdPFGz684+lwVn7jGl0QyWm58oY72DZ8NRD703czHZDslRNMCghtq6YwfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH5DvWREHtG3pRYM7LQvOmalK1dAAGqYb2lum8FzLhg=;
 b=eAdcAzlOy3CldusQZWHAISaH2q1nyBZ53SaIWZU/kSojNRhwcrtbxO4kgWBj/mMj3NLMgAgJGTVjStlgsX6fctCztfO5hugrsBNJ+Cfev4wjDPIE96V6GKc7h7ZsJd2hKuOJSoDe1Ysh/Z4wksb+zRExMAMdWt58cWQIUr3rDvi7kSkdTwNg3qfFD5rMXRWcmZtfsGbZRyTNZ/4XVFhOJZ5Fvl1ppwLDkYFYBo1wVx9GYphAXYvG5heAZ8AmoSbxCQNJUNZlIfdM0KAEwST168KEethEd5dRyXe3trAV5hduwiHYQtbHzkdVEydEWfQufjGWkJxKrw04MKwciPbMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH5DvWREHtG3pRYM7LQvOmalK1dAAGqYb2lum8FzLhg=;
 b=E+nbAnYyZr0zkW5ayMDvWQa0y+3vmFOWGh8syEpwDpvm5eXF0MEk5O9n1iLgnB9QuqgzOoyARAVk/fHlAchSsUA1yd3ci85z6INsrvr27nh69sD2PZVLwaX018GROFsI6oITys9b2/FZcT5Ed1NUAOERcHRMWD2Xr65X3SlTOhA=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0921.namprd21.prod.outlook.com (2603:10b6:302:10::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.2; Tue, 15 Sep
 2020 19:22:29 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3412.001; Tue, 15 Sep 2020
 19:22:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWhTK4CcuAC1huL0WTSe45bNSLyqlqIGbg
Date:   Tue, 15 Sep 2020 19:22:28 +0000
Message-ID: <MW2PR2101MB1052A6B693E554F03F9C9038D7200@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
 <20200907161920.71460-2-parri.andrea@gmail.com>
In-Reply-To: <20200907161920.71460-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-15T19:22:27Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70425c3f-e195-41e8-993a-712b53ca6095;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fb5675e-4481-4575-fbab-08d859acafc7
x-ms-traffictypediagnostic: MW2PR2101MB0921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0921B7B3460A1B1852FD3FB5D7200@MW2PR2101MB0921.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OwnGZ4Dl4YMmdxuPYN6EZhG3SBq2o2bk4jk/+Q27xu8yGjnZLz9k4RrP5bRRSt6igqXAyjdCF8IkvzcnpDJHP/jN51DeYEJ+zuYgSTTmCDnMbrgh+bzjzjjIJ7yEv1wtDkpuWngs1cI15gnIrFIF2Z32dspy7XRCRrgdCe4NRPEo1mzJ/JLHcmwafZJxEYR2sleMvYkrNPdCFIS8jSQBRG0DEyAmLsp4snpA81B8SJ6QjqzoCqksIOy6KvGLIdk7VE25rSihzo0Nx4yU65l/lQI6AFMLEQKKVg9fNWaVakUVlJXKBowogXxcZnXcj/CJDPw86Y5PpqxDLGXbNLAoB2KkDRJp5fz22axIft698CfLUhtOGcebfGt2ZfuXfL/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(10290500003)(6506007)(7696005)(110136005)(316002)(2906002)(33656002)(26005)(186003)(54906003)(82960400001)(8936002)(478600001)(8676002)(82950400001)(66446008)(52536014)(55016002)(4326008)(9686003)(107886003)(76116006)(64756008)(66556008)(66946007)(83380400001)(86362001)(66476007)(5660300002)(8990500004)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JUGfGsu+WD0PSJrSHiEjyXFUCvl9GfF1rgZ4saqiQNNBjgEnDatx6QHdscu34Ao2uN2mgcnL5CYDhhAhKM2Jj5tQaG+GislZXTPjx1atBHMFHKczcj9A4w9pUE2r/9XIiW/gkfIkujdYM10GEOsQ0DJc6tgQcXPX+ofoG4AhqaZST6tPaM3o9j+g7KWeCohdnAsS+KYZ6TWR5mJzdkNpZmrLo4ScUyFm2X9WX8mnZBhpuMwJCQ0utHGWxagYhOo5+D4tKg102d92ZxzwoX6okYEFt7E7/1Yko/Rc+kseaCC1cDmC9Dw3NQaJOG9vso/cWN/MBZeUL/FA2qienuk10Rg5zjuKynUxVqn9OzxK2V70FBy9FqG5rCUYXSv6I1Tcnuj0wGEd4TMBW911u2mYLSYzIP+P/pqpFTaO2QyXPKz2dJ71nVYEUcpUOQKS1ZNuxobdho5/833dzkGDMx1zE4nBTMkeuoZM8dJaICZQGfa/qSKchjibG4LkR4rQ4hvQMvklRODNHnzyBPuNykDTK4qENnoJjcR17aBMi6KjRVE3oultJ2hhZaYG1v36Q+JVBNyIY3pnMb4DgU0f8Fdxdo+RG9H4ICIIUvoZegdlemZ/yWJKeUaQIv7vxggUvrnE/VnXjX6aS5EMLE85JLr5mQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb5675e-4481-4575-fbab-08d859acafc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 19:22:28.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGJeTaKVf/ToUOMVUWG4msxMSVNfV1OaZjH1uz1a2Daq1papeIkEyKvDNVDu0lmE2K9pTXw1szf8KNkRQpBHhKRiWNpcwFi4IHDY59G9OjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0921
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Septe=
mber 7, 2020 9:19 AM

>=20
> From: Andres Beltran <lkmlabelt@gmail.com>
>=20
> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
>=20
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes in v7:
> 	- Move the allocation of the request ID after the data has been
> 	  copied into the ring buffer.
> Changes in v6:
>         - Offset request IDs by 1 keeping the original initialization
>           code.
> Changes in v5:
>         - Add support for unsolicited messages sent by the host with a
>           request ID of 0.
> Changes in v4:
>         - Use channel->rqstor_size to check if rqstor has been
>           initialized.
> Changes in v3:
>         - Check that requestor has been initialized in
>           vmbus_next_request_id() and vmbus_request_addr().
> Changes in v2:
>         - Get rid of "rqstor" variable in __vmbus_open().
>=20
>  drivers/hv/channel.c      | 174 ++++++++++++++++++++++++++++++++++++--
>  drivers/hv/hyperv_vmbus.h |   3 +-
>  drivers/hv/ring_buffer.c  |  28 +++++-
>  include/linux/hyperv.h    |  22 +++++
>  4 files changed, 218 insertions(+), 9 deletions(-)
>=20

With my previous comments shown to be incorrect, I'm good
with this code.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
