Return-Path: <linux-hyperv+bounces-996-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1291C7F2218
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 01:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79D2B219D5
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87223EA1;
	Tue, 21 Nov 2023 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EpJH6Dwi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8FB9;
	Mon, 20 Nov 2023 16:23:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH9INZaP34l3blKEsyxhVzIR0eTUW92J/Fw2yH8JENqaFgZIZPS+GIWxm61YJq6keOrGaOJCGv4Lwp0PCbRmhzUkp4s8jUHMwUOZnoqp8Rp84X12MKOshjhVUrt5+XKlFBlA20dreRcXETDgVGia6238prQSduRKl0VPb/ZbznCVZfwoUiWBG19XnDLgSkDsjdAKaxDC0kE8yFHyyBXtDifqI6UokJPs2G4JXkr3m16gMAG9TT1Kdw0Nsvfa8+dxwcp+pJ5uDI0IiHMSvCfA7Z/c8Sad+lgYTzTsMBYArJji5WA0bnnWFDs2Qci+cBIv3wFzHCCYSJFIMH8TWcfwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98X5uKpe/5lFiSb+gz9fkb1SSkVYPOrzm7E5PkhNXBA=;
 b=Nxzo13YWJsWkEeJ9FqhrLAaxTcMsu6lXVjaAsWkAEvgIItbSiS9qZWkbRYnVQa38RYf18/BrS8m/Hz2xdQ6xqvs+ZCnhYlcOvFk1r3CWhbFSk/ccta7zMnTFM3cgDdQRR3YASjunieLxuqPkGOXWh8qNoP10oH8iHS0cONNqeKN++Y4BbYeYjw75NDYQeH3SNQ+8b6JO5DwliOOLioWlKLSBQ6ZtdBsECxQd4rgtSVUsgU0OVV/l3BF1uaXTAciVs3TSlzLoGMPhKbiD2Yi1Nhq1G+9aAqr8Vmi1v7Qv7AahJMezFrJ95PgznufRrdYG8K7WoN5XR63XcoyYC1GVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98X5uKpe/5lFiSb+gz9fkb1SSkVYPOrzm7E5PkhNXBA=;
 b=EpJH6Dwi1j6dghmaU2YYaxbQkB6Hf8UHTa5tbQy6q/ejY59QAvWFowp4zXv8YCy+aWzhwItMRjDZhkuWaVcDY2RlXtCiMVlRNDM3YnbLAqa/byOGt6leQBbm77Jbf3PceKAWVdVF3LFnVBeSzFgKBjhQtiJtWc72LcAqwMfTaZU=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SA1PR21MB1319.namprd21.prod.outlook.com (2603:10b6:806:1f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.9; Tue, 21 Nov
 2023 00:23:42 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954%7]) with mapi id 15.20.7046.004; Tue, 21 Nov 2023
 00:23:41 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, stephen <stephen@networkplumber.org>
CC: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Thread-Topic: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Thread-Index:
 AQHaEpbleF6H2i0O6EK5idFzE7vPXbBxP20AgAAPDICAAq7HgIAHmxUAgATOqoCAA5TaEA==
Date: Tue, 21 Nov 2023 00:23:40 +0000
Message-ID:
 <PH7PR21MB326308608D52C45BFE16B05BCEBBA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
	<20231108181318.5360af18@kernel.org>
	<PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
	<20231110120513.45ed505c@kernel.org>	<20231115081406.1bd9a4ed@hermes.local>
 <20231118093849.14e36043@kernel.org>
In-Reply-To: <20231118093849.14e36043@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b93cf709-6b7e-4dcd-8991-3483ff0f134b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-21T00:20:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SA1PR21MB1319:EE_
x-ms-office365-filtering-correlation-id: c5ae9f75-e709-4096-6667-08dbea281cf2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZRaCtTsiZ4drzHQ6+pfRMSlLJ94IaiVmzQM6smF/c0dBFlRkXqkTPVL1W/90ttBByknjdmpEdRlS/TZf41eZ01x/aIO1t2NIZoblVwRqclOFxCEPssuLM+dG4Gy+PXiTIy6lffNDf24yXvDCAsa/9c+V2q71AEcyTDXLr5NGCVXBD1L0wCd0rBOw7o6V0HuJbDRVlcQbirND8KrkIE4DQjjxv4J++CcPu4IN/vftO3UnJjXYE+vqoq7vk64AZ30eZJUopTf3Ti4023pYZjtOwqqeJVr6a8/tPhRtH+uJSBDW+n9ClDbYQIi5uKMu/vLs8nc6O7VJT+2m0dxINdriKAeADdmKVN/WBYviHyFQGzQtxHdBS/wOXivqPIf6B4nSSDeWXtw7fD9TT2j9kLux6aK7LTsDN6E7BRLaZkELdpbVHSg0AtVpMNZwYeabLWGa1hQT2s14L85G/guOd9mAAxBNykMe41T9Z9UHVFdb0g3BtWyebQ4R1rK1gXmzLTn/GnscLRz1n19bij04ae5TD/OycYRqRpbcXJa2zoUKpPczVMRbhO/ngTOmCnjc6zRO4h8wZWxQ7x+bSYcCu5DU78vpoSGb5jQjIUiQlv1JIwYLR5D3o5lXHPRag/a56cGaHHSLXDQ03WW5E+14ukcpXaTT2Ewtm7v5k2KBLgZwXX4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(66899024)(38070700009)(26005)(82960400001)(82950400001)(52536014)(110136005)(86362001)(64756008)(5660300002)(76116006)(66476007)(66556008)(66946007)(66446008)(316002)(8676002)(4326008)(8936002)(7416002)(54906003)(6506007)(7696005)(41300700001)(8990500004)(9686003)(71200400001)(478600001)(10290500003)(33656002)(2906002)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UO83f/ovzyk+eX0SOiSsGzzVkFCmQseAh4tmrMRe/xbcc+B6IwU49Is+iaky?=
 =?us-ascii?Q?P+rOw5KsDmk0qHzV0pjFbXW/h9c3o4rzeHsxeg+nCjSbFpN/RLrjf+CKTbgw?=
 =?us-ascii?Q?gHZlrYKrTUR4kCfW6g58Ts2e6Uvp3HvWZmE2zQQTzw8haxb7AzMdKQ6MG7RY?=
 =?us-ascii?Q?IPCtFGl72w22L0D3sRQ4J/isvvgoUVEfSUpm/1HP4LKHsGV5/06IDmNRpSe+?=
 =?us-ascii?Q?alLJZXWe3cJabUdTG+gPmt8Yp29ewb6Z+Z7EZ1cUcdtPYznl2PdHt1XmnWAV?=
 =?us-ascii?Q?9MeH+KqA+kPnpc3KgMUheSAbf8PNREx5b5XVDL1z/PvkV5GVOOL064Jm/0vv?=
 =?us-ascii?Q?zwCVJZB38bI/Vy2QR2XxES39oxLi3gBU+ikhiDTWmGpHgdQWc/47aodM9+0u?=
 =?us-ascii?Q?1gnSan9l5u3qDznrVAxl0vTv6ZnLm/Mx+ZAHpDLcDZvnxcjBsvtZVQuEzf64?=
 =?us-ascii?Q?i7Rn/XEefmlSVKiT9praCiPAgX52GjTurFt5xjaNhk+jAPmdt+g9v2A9Dsag?=
 =?us-ascii?Q?uECD7RFq2mGXjTUMTgaqe/ce98c+SrJOYU1o0wkaq44XHBhL5/2kiai/lWIw?=
 =?us-ascii?Q?Ifaw7BQSKuh7I626xM/5BT3Cq7V5zN9Afq/2XsBJgcT3mUJPJNNyI9J+Us6b?=
 =?us-ascii?Q?/2JexVRo/DY3BS9/mscaqkihZrppZT2FOb0xF5lwQzF4JviLcMM8kz3491pV?=
 =?us-ascii?Q?k8u3nGDSNzViTmRw4UX2mlRX6KCYilasNVTgOih9uBLJI8k5Bo0jnuTlH+yp?=
 =?us-ascii?Q?6puPxaXRoq7FazlHWvbb0OwhpoKOB83BZGe+QDpYVY46YX+w1yCtbke+d7jh?=
 =?us-ascii?Q?bb1rhalLwuxRxPyVioQL2eAtaBbayhK1oOKJ+gHkfvIgxSwjGX/ODcqr+K3B?=
 =?us-ascii?Q?ZReQtokfPXMdJqkVrNP0gzMuZ5AD1FO/RtynpZZwh7r7e8K6smUuDNPURbH1?=
 =?us-ascii?Q?/okKtZp8RVX3PKHWusX4nr+vFw/tniWs0emmeyb/B/etg1q7brad8+kUDDnR?=
 =?us-ascii?Q?dD077CC5Gs7+rCEl4T0s/eBJO1x98a8AiOIJhGSVk4V6JWBG6D3lNU0SCjFw?=
 =?us-ascii?Q?JHsS8ZY3ktAxM9I2kv/awaniaVuvpSI4RpGFGuT6f4hQ1kBKb4+5+lNNJcJr?=
 =?us-ascii?Q?gysTHnK5zkkI177bn7DX4Qt4pelELgPLg2yrKHOV2Xx4h93Z82UOfx00BT+S?=
 =?us-ascii?Q?tkPvBXUgHZE4jhevQSfLKp3unhwp7WUMfL5CyfXv9FFTnN0I6A0dAhi8dvu5?=
 =?us-ascii?Q?40hjm/RpB8w80SqeeLCVYPhZDvqK7HUmMrCX083+56Oxa9BD/xB8pWB8Y+e0?=
 =?us-ascii?Q?KtRvx8W+oJSRHPTEK22CvT9D5rG2mPIiAZfORYZorIVBoYPJj2yLqXxm/pRr?=
 =?us-ascii?Q?mT75CXpLN/hLFgRbcL6001sRb9zcyUREuzWkcAuDRLDkR3zWpInwquPrulK5?=
 =?us-ascii?Q?5o64wIk0rAO+I6CzHvF39V6FdVEu+3Y512TN5XH8QqX+NBz/LD8T0q54IpBF?=
 =?us-ascii?Q?OGA4L8Myb4ER5GH8MhoGpA7Q6tpuat+YeMmnZwHk3q19uZqgCoO+Ji59QDjJ?=
 =?us-ascii?Q?n3uk5a3hZZ2EYhJPpmcAZKu+NQlyvJSonWJZzEJx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ae9f75-e709-4096-6667-08dbea281cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 00:23:40.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQRINEvGybcvaamLvLiACFRPdgXvYscfMcT99d/4fO4ZMGdNzINpnn0+JDRXSum+PAai/0cqeWwim7WZJ8f+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1319

> On Wed, 15 Nov 2023 08:14:06 -0800 Stephen Hemminger wrote:
> > Jakub is right that in an ideal world, this could all be managed by
> > userspace. But the management of network devices in Linux is a
> > dumpster fire! Every distro invents there own solution, last time I
> > counted there were six different tools claiming to be the "one network
> > device manager to rule them all". And that doesn't include all the
> > custom scripts and vendor appliances.
>=20
> To be clear, I thought Long Li was saying that the goal is work around ca=
ses where
> VF is probed before netvsc. That seems like something that can be prevent=
ed by
> the hypervisor.

Hi Jakub,

I think you misunderstood my response, here is the response again.

(quote)

The current workflow in the kernel looks like this:
1. VF net device is created and expose to user-mode 2. VF is bonded to NETV=
SC (if NETVSC exists on the system)

With the current kernel behavior, the user-mode can possibly see the VF aft=
er 1, and before 2 when VF is bonded. When this happens, the user-mode does=
n't know if the VF will be bonded in the future (it may never happen on sys=
tems without NETVSC). In this case, it doesn't know if it should configure =
the VF or not.

(end quote)

The problem is not that VF could be probed before netvsc. The problem is th=
at it's possible that VF is probed, exposed to user-mode earlier than netvs=
c has a chance to bond it.

Thanks,

Long

