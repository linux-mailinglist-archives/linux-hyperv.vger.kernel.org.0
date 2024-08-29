Return-Path: <linux-hyperv+bounces-2915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C0964A38
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1AD1F23E40
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB01B29B7;
	Thu, 29 Aug 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KHLOzEDo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021124.outbound.protection.outlook.com [52.101.57.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD553A1B5;
	Thu, 29 Aug 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945976; cv=fail; b=otJb1Yr1jUuT/sVdRBQAOuFDZLBPo5RtyBNbQMxDmv7h3L8XXDo70Tnr03yhmSaKZQl77tEyG1rUUDebZFYBcBF8rdAIDyfx3Ecv1npRoGv1zf6lAKjJax+OpuXRLnyjOmTiOjsE/AWL8Tks9GYRihekm/QBhpztgCSiNDdtiDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945976; c=relaxed/simple;
	bh=u5HuEjP2Wl7ycDXKkTNINnzYRT6wZRuTihniasKPmtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEoUMuVh54l8gU64pB/ljZGyuRPvm+0lijOJQuJU7BBKhT2VMc6bHta3eA+RlQFegCcAV0rJdBDfL3vPKI1jT66nDvFh7ynfI6KOwHU+bgv/zL4LIU9o4qqzFPH7u+uMii6xZCa0S4zThXg+jLjIP7EA/ACcm2LoDn47mqTGS4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KHLOzEDo; arc=fail smtp.client-ip=52.101.57.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URN1BkNz/DG5yhMYZ7Rq4WhI0F5619MxtPzbmfn0GvGO0lueHqWSUsRiaKbtAKkiXTLuTqW65bhCzB6irKqMbOpDJVbJd99wDSFTh9glVz3WB9KL++o2aK2C7poXpsXgQOpnEJHHe2+CEJSLcJOEQfmeTdWOsOlPv61F6SPZowJog0ZoBYNxEFv7e3OXKDOKe/CI2lKGWXvnaeayJcpZqb6oWRv0RoxBOOY+PRzUwY5CMrgbQ9wrthufkVTIvk6+06m7O6nBPMyXPKWWJqgWUs58HfSQFQEKSU5WN0Yfuvr3FbgCg5XwL1+FZOhN1gHZl9E4kFqkTPEyuZbiNgtpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yu+HuVFacqx+zHlmw9VYQbMEMizXtNxN8ea1MguKng=;
 b=HfvI41NU6mRfOU3S5SVR3dUnIp0TRUH/Bz2B6ttkjzFfROScSDy+yFRvl24vVOdWTGBobw/tEErA94123nQ9rCg1fW5c6sC16dnSRwAgReidQOnmrqdO0liMtfsEooUTLfK/zBGCaPh2yBKN9AFO0kXuzrLK2RL4SXYjxECkJMGcRDE/laAP+Xukb9uH5uQ55JNMFHStrTEyyTgjD2HopOHUaTn/zxu9qcbJCu6b6few4m3okrvOX4vEob5ougExZGHrBBrK7glB7QKAIDIjkrijmq/nGP6i0kjyyqYPHt6uXapgEGQFRf2KERamY8Lb71OF6MZfN9RMkUKJ+SoS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yu+HuVFacqx+zHlmw9VYQbMEMizXtNxN8ea1MguKng=;
 b=KHLOzEDoCCwW1Wbp8SySoJ/xxPuDoaZfuVkQq+gl3+DSJvnaVgDFN7q4fec5QYLEDhxkRkrjCG1y7tXBNSofd093Or22bQWZRpsi8Zkt7CWViJDRm3DJ1wrQ0Sqj5WlH8kKUQb+U7SR1z4uWIYGwTjMr4ATrao8ZNH7eGFaEJCQ=
Received: from PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15)
 by DS1PR21MB4472.namprd21.prod.outlook.com (2603:10b6:8:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.8; Thu, 29 Aug
 2024 15:39:31 +0000
Received: from PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0]) by PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0%3]) with mapi id 15.20.7918.006; Thu, 29 Aug 2024
 15:39:30 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH V3 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Thread-Topic: [PATCH V3 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Thread-Index: AQHa+e6j7hVwv/g+nkyjJvATfz6ZwbI+VV2w
Date: Thu, 29 Aug 2024 15:39:30 +0000
Message-ID:
 <PH7PR21MB3260593DB0EEB77468BAEC83CA962@PH7PR21MB3260.namprd21.prod.outlook.com>
References:
 <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b5130f1e-2533-42e5-a1ae-40201749db0f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-29T15:03:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_|DS1PR21MB4472:EE_
x-ms-office365-filtering-correlation-id: 4045051e-bc3e-497c-b2de-08dcc840c620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9eX3grQjD4YYmFzGKMA1VU674Lr21ut+A0EPRoEf9yXrsW6W3pNoNdhHxuic?=
 =?us-ascii?Q?KgEoJ/HCCk4xkZ2Rda9r4FZjNR1XDUsFnEkrLj7Bvyj0h6V2/V82X0ZoAQSf?=
 =?us-ascii?Q?58rAHG2nudleE69dUJhvm3m3tOn2k7QqQrOUw9nzc1PsgkJRlb0nW9wD97nX?=
 =?us-ascii?Q?iXhhPGEK4+Atj+yDt/SquhKbMkz5lBM2vtdHZBX/mtK8kiB5ggcNfjFHTthR?=
 =?us-ascii?Q?Wgv1HRy3UEDpeNLalXTcl4QALwyhjaB7boPaFhsA4/EH5GzbfCgbBxz1NRSS?=
 =?us-ascii?Q?kpMyaIdB5bCq9DQRJT+tlUqQfyMZqkbmV42iAqlFvUQybxGG2ppRvVdHVnsL?=
 =?us-ascii?Q?byQIyTLE2oGkqeuu8BzXuYtCD71Gmbc6T4FWkVVXFdiKwNP2QUKe7XFc/8k9?=
 =?us-ascii?Q?dzwFxbLBj2UEYKYC+uRGuBiu2hDWqweZJRnKi8OT36TXJGM2GKC27e4i0KSH?=
 =?us-ascii?Q?D4Z8ItCxgM+mA2nRqKfMPRvVqoT+w5xc684huHhojhhIzZKOWVFvyA0Pf/ML?=
 =?us-ascii?Q?pb30ujqZ2/Hhih7eeY6Kn64GlN/o5POVdMImBWvK5xuuP+yyKKjv+eRN/8Sd?=
 =?us-ascii?Q?2lDfBFRRbRb/OuR9mQcKsrMKllLaMVDgya48fshWyysgh0QM5VO2+wm5w2ad?=
 =?us-ascii?Q?ca8rfpfczEmVFeEEdQGTiV8sSnZ7v7hea630IT57QmXUAu0HqHesYq+beXz0?=
 =?us-ascii?Q?eRjhQo3S7BsegRmXphCb+lBgyPXIezhN2JjxywyoVDbnFwMvfE7jyRKxkC3x?=
 =?us-ascii?Q?p0klk32ZK/SsvG3rJOPRf5htaZzP8zRD0qzXy3wv1Gr6B3sjesljNU5hryGs?=
 =?us-ascii?Q?QNX7yTksabT6k+4rNcwbA4k4JbvxwW2JilZ+vuagplDNVpD4LGpWnz7WTFut?=
 =?us-ascii?Q?9db72mGibHl6YxTwnT8yqv3iFC+Wd09nBqrzZ8r5aPGb8GbUBHGsGgZ6O6kv?=
 =?us-ascii?Q?A/1hozoQ4tad6p40I2MzYzNz2E6cdpHpXaKwlU63BXRiIRE4tphfxs413V8M?=
 =?us-ascii?Q?rVSp09/jEqVLEV+N7E9F2oftiOmW6Zg0GXFvSI9BaP8bh9BEvfjw+YqntRys?=
 =?us-ascii?Q?e4PI/x3sW+ZCVRqB7Duoatd6ZT1mrghp0B3XAisQ968ZSnQ7LcYo17LdOc/U?=
 =?us-ascii?Q?K5YmLBl8XLeErae70HIUMx1Lb8uxp9LvwWAPn0+9pozhv+RtyI2fGmrj1fp5?=
 =?us-ascii?Q?0ox/3igYP/eetP+Gsrl95OxkzqDB4STXQdgMRRnT3/YO2P2RQ0TsbhVPHk1b?=
 =?us-ascii?Q?Q0QmQU/54x866NLPZRFTCIV3Ev+jXLs9GB9y1bML/pCEIyoLzTx6cN96FdQc?=
 =?us-ascii?Q?x9H0nmklpj8xzJO3ohGvGyzyRFGmsLszOY505o6uAH7iulZAzu2FYwehhgjT?=
 =?us-ascii?Q?r2RmPC+jahx1vRIF0Vm1K9olHKqh5IU86LH9ZX9yIAhAupiIDPlLnjg/+oOB?=
 =?us-ascii?Q?P84/XMLBga0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3260.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZiMPupg+VGIUJ+5yBV6+VV1yLjyaJNy71rwpi758hp3Gwfsd2wL/d6nZClYV?=
 =?us-ascii?Q?hXdPaQ1Zu9qishJ8qZkpZ02pP7BlLs8qiEuHCfpH26I1eYvdkcNrQqg1nwfz?=
 =?us-ascii?Q?5huJjJnwo8UlU6Md7uwAXvcRFvcHXCTIbYMnFDL+MdFf6BsRvp1rFlMEvKn7?=
 =?us-ascii?Q?AMbye7K3YF7TbzTTTJQBQie0XweZC4he2kOgOwY3RwbjDOYZ1TWePtWPXjRp?=
 =?us-ascii?Q?SNVRbB9mNv2rxM9/Ro+Qu9WTNSgjxBO2DSwwk7CSHIerq1Iq2Xhp93TGtN+C?=
 =?us-ascii?Q?EUFl9oiOMO5/bM7JEjdaKPGNa3O9jZ4y/cuI706BDTNUJOeV2Btlvcq1AfLH?=
 =?us-ascii?Q?nNdc6gilMpBJ0w2cU/rXg6ox3nAsc/JnmpIB3tTXtXQ9AgY46tVJuuBdXHx/?=
 =?us-ascii?Q?QWEyXbfr0gSEFYDqwNlmgNwPJbAkkQ6+T2NuAwK5w2q9v1CqEdUFWf/Lclyw?=
 =?us-ascii?Q?8a7Wl90uwE3PqFR/l1jjV6FPNaDZTo3uy1YsSKCcMvqBNcr+p5UeWArcWPVQ?=
 =?us-ascii?Q?rP12p84XJa4WewK2rXyirk3QcRAYDwK2WyGuN2cCoNLVmZw+qxzM6V78+0rX?=
 =?us-ascii?Q?0aMrNJnkF6PrAyEhzYrz4GZgF40iQ1PdTFoW56hJMnC5uHsilT+RHEmO3B/C?=
 =?us-ascii?Q?/WRU2OYIO5fYfmE0OyXuXG0h02kCP8zx12NjAV+t2rFAi9F9X6sLZQ2bSX3l?=
 =?us-ascii?Q?IVKP/7DPTPFS/LGBDJmZJoRcpjwkML5QLAUoY/uy++nOqyOBRCVwtzY2wg9l?=
 =?us-ascii?Q?bTwJ7NJu/BN0p+9ftNUjdtBBVr/GDlBwz0eITJrpzr8FFeQfTZiYPr0pnPR/?=
 =?us-ascii?Q?l4gelAqSTrbaFZCVs+ZsfcHkm3wg39bMP08NrftXMXq0uVMOgHc4G0o03UTS?=
 =?us-ascii?Q?BNgf8dLNOySu+NP9yZfHT7l+Y8M3mppQK97xLvWUkHeSn1x9E4COX5oX6pY8?=
 =?us-ascii?Q?HGyiEjx67yxqsRaBm8caKcbi0MovWi9Ca2apJHKUmBBAfagifBPiEtNbsQph?=
 =?us-ascii?Q?9+7l6zKwkYc6cofht0mwBC5OzkGWUowzj0te/IVk2GB5EECbvEPqT9MOFypa?=
 =?us-ascii?Q?gVi0iVVAJlby9pA07LmhpSCBd8k9sVe1ArDjxg0sH/iYAx6jiahtqtelMmnL?=
 =?us-ascii?Q?m6apttyl8nu1WMjHvsbDv/54IUKlQQu3Xk/Nql3WPLTHVJXWmReMZOt5aYq9?=
 =?us-ascii?Q?OR297JhWFJUMwpMifDB4P38fEzlM/OK/0I8Wqba9cQrdg/FHKS/NJlqb0rud?=
 =?us-ascii?Q?C+wE3hfDXyM+75BTUNndZsRjAnpCZwxqFAvVXZbWa/WN1+6su/+4vlNCupeF?=
 =?us-ascii?Q?bXOwP/6NYleh+MWuA9my2R4kPTUCKez7ajNRx2sPOLUf4H4A0cf74f9lb8ku?=
 =?us-ascii?Q?AN7tDge873p2XqYeGZkKdNrZpq6ckEsit6TpCcSYmXThLtJpm1n0MMxqRx7t?=
 =?us-ascii?Q?I/E48x4Vp0bh2Tl4bafIojf234KU+jlfT9yYTlukdrHNJWHkfZDvGgcZa+0L?=
 =?us-ascii?Q?XUoJrLSMWvEwDx+dgzaqukYhkft1f5HWbqvIk1Vo6jFw7D+8i49GpbtdV9KQ?=
 =?us-ascii?Q?ZDbweq0yo2C5/qUxIDwN22qIbvIbpx7aGTUbEfMT?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3260.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4045051e-bc3e-497c-b2de-08dcc840c620
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 15:39:30.6688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Q5et6tzAcHytrk0vE/wbkyrcLJLUEv6RQyDLub9bEWHLIyuwElbfIaw+kjtG9lCtii2YVC/FS9tEoE/CzNN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4472



> -----Original Message-----
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Thursday, August 29, 2024 4:37 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; Long Li
> <longli@microsoft.com>; ssengar@linux.microsoft.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Souradeep
> Chakrabarti <schakrabarti@linux.microsoft.com>; stable@vger.kernel.org
> Subject: [PATCH V3 net] net: mana: Fix error handling in
> mana_create_txq/rxq's NAPI cleanup
>=20
> Currently napi_disable() gets called during rxq and txq cleanup,
> even before napi is enabled and hrtimer is initialized. It causes
> kernel panic.
>=20
> ? page_fault_oops+0x136/0x2b0
>   ? page_counter_cancel+0x2e/0x80
>   ? do_user_addr_fault+0x2f2/0x640
>   ? refill_obj_stock+0xc4/0x110
>   ? exc_page_fault+0x71/0x160
>   ? asm_exc_page_fault+0x27/0x30
>   ? __mmdrop+0x10/0x180
>   ? __mmdrop+0xec/0x180
>   ? hrtimer_active+0xd/0x50
>   hrtimer_try_to_cancel+0x2c/0xf0
>   hrtimer_cancel+0x15/0x30
>   napi_disable+0x65/0x90
>   mana_destroy_rxq+0x4c/0x2f0
>   mana_create_rxq.isra.0+0x56c/0x6d0
>   ? mana_uncfg_vport+0x50/0x50
>   mana_alloc_queues+0x21b/0x320
>   ? skb_dequeue+0x5f/0x80
>=20
> Cc: stable@vger.kernel.org
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> V3 -> V2:
> Instead of using napi internal attribute, using an atomic
> attribute to verify napi is initialized for a particular txq / rxq.
>=20
> V2 -> V1:
> Addressed the comment on cleaning up napi for the queues,
> where queue creation was successful.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++-------
>  include/net/mana/mana.h                       |  4 +++
>  2 files changed, 24 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 39f56973746d..bd303c89cfa6 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1872,10 +1872,12 @@ static void mana_destroy_txq(struct
> mana_port_context *apc)
>=20
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		napi =3D &apc->tx_qp[i].tx_cq.napi;
> -		napi_synchronize(napi);
> -		napi_disable(napi);
> -		netif_napi_del(napi);
> -
> +		if (atomic_read(&apc->tx_qp[i].txq.napi_initialized)) {
> +			napi_synchronize(napi);
> +			napi_disable(napi);
> +			netif_napi_del(napi);
> +			atomic_set(&apc->tx_qp[i].txq.napi_initialized, 0);
> +		}
>  		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
>=20
>  		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
> @@ -1931,6 +1933,7 @@ static int mana_create_txq(struct mana_port_context
> *apc,
>  		txq->ndev =3D net;
>  		txq->net_txq =3D netdev_get_tx_queue(net, i);
>  		txq->vp_offset =3D apc->tx_vp_offset;
> +		atomic_set(&txq->napi_initialized, 0);
>  		skb_queue_head_init(&txq->pending_skbs);
>=20
>  		memset(&spec, 0, sizeof(spec));
> @@ -1997,6 +2000,7 @@ static int mana_create_txq(struct mana_port_context
> *apc,
>=20
>  		netif_napi_add_tx(net, &cq->napi, mana_poll);
>  		napi_enable(&cq->napi);
> +		atomic_set(&txq->napi_initialized, 1);
>=20
>  		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
>  	}
> @@ -2023,14 +2027,18 @@ static void mana_destroy_rxq(struct
> mana_port_context *apc,
>=20
>  	napi =3D &rxq->rx_cq.napi;
>=20
> -	if (validate_state)
> -		napi_synchronize(napi);
> +	if (atomic_read(&rxq->napi_initialized)) {
>=20
> -	napi_disable(napi);
> +		if (validate_state)
> +			napi_synchronize(napi);
>=20
> -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +		napi_disable(napi);
>=20
> -	netif_napi_del(napi);
> +		netif_napi_del(napi);
> +		atomic_set(&rxq->napi_initialized, 0);
> +	}
> +
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq);
>=20
>  	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
>=20
> @@ -2199,6 +2207,7 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
>  	rxq->num_rx_buf =3D RX_BUFFERS_PER_QUEUE;
>  	rxq->rxq_idx =3D rxq_idx;
>  	rxq->rxobj =3D INVALID_MANA_HANDLE;
> +	atomic_set(&rxq->napi_initialized, 0);
>=20
>  	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
>  			   &rxq->headroom);
> @@ -2286,6 +2295,8 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
>=20
>  	napi_enable(&cq->napi);
>=20
> +	atomic_set(&rxq->napi_initialized, 1);
> +
>  	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
>  out:
>  	if (!err)
> @@ -2336,7 +2347,6 @@ static void mana_destroy_vport(struct
> mana_port_context *apc)
>  		rxq =3D apc->rxqs[rxq_idx];
>  		if (!rxq)
>  			continue;
> -
>  		mana_destroy_rxq(apc, rxq, true);
>  		apc->rxqs[rxq_idx] =3D NULL;
>  	}
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 7caa334f4888..be75abd63dc8 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -98,6 +98,8 @@ struct mana_txq {
>=20
>  	atomic_t pending_sends;
>=20
> +	atomic_t napi_initialized;
> +
>  	struct mana_stats_tx stats;
>  };
>=20
> @@ -335,6 +337,8 @@ struct mana_rxq {
>  	bool xdp_flush;
>  	int xdp_rc; /* XDP redirect return code */
>=20
> +	atomic_t napi_initialized;
> +
>  	struct page_pool *page_pool;
>=20
>  	/* MUST BE THE LAST MEMBER:
> --
> 2.34.1

I agree with the idea that adds napi_initialized for the
state.

But the Rx/Tx queue creation/removal are either on the same
thread, or protected by rtnl_lock, correct? So napi_initialized
should be a regular variable, not atomic_t.

Thanks,
- Haiyang

