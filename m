Return-Path: <linux-hyperv+bounces-7696-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B92FC6BB52
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 22:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD48B365DB7
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D9D2DC346;
	Tue, 18 Nov 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gc97k8m8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020123.outbound.protection.outlook.com [52.101.61.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9972C3745;
	Tue, 18 Nov 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500731; cv=fail; b=gfDfyIyK5zfyjFcE09f8xbWhkS7Ns51kGH5hz9PiNeyYmaTX9Y5/VkZ6OrUmmB0PD3I8l2e2l67Md77Y/NUDPB62hYHAfUfFTA9rOtP2p7wsSoEoMwLK+QLSYJRyrYUkJe/mBphGWF0EV9tD5poU6RBp/fm+03KiuKeYrgdl8bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500731; c=relaxed/simple;
	bh=VFCYfeR9VZAbgwxrgnyTz73UEs+FAZWX37DjjUGzNIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cchIxtuZtzt8jkgK9Xes3Ms4G/voauUhCAW3EZj9zgkI6v5559oTcpOPtc3sFtq65KokdadHyL/85tb4KRCsZLY+Ad4fpfHnJszrzcQs0HEo0EdzYZsv+9mKq2FsR70Z9h0RUMkDJLIuA0wvqKi3DDZy+VvP1WZlw0RSPwX8efw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gc97k8m8; arc=fail smtp.client-ip=52.101.61.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuX84hfKaNT74WaKaL/9ESRBn5TBENe+6IEURNu2wtrVzCN6FpIvBhnik4mAU643V1gIcaXuHA/cdmecZ5mmOdPY3FaU/BOCcy/+eYUmlaPtN/5vsTWVuoAc1vMDn1nISLPOefrxtHoGg64aw+AIskL5/eU/YO2+Xs86QPPBX8o/jVpjkjmJsDMhsUPn/GiWtwEpoaa9Nl4CcTdUZMkFAlEAqgpR12rIln9LAyuPw3iCoGxrJcez6Lg6WkuwhRSObi2elN5IWyPTnJmm3l15A537kO0p4MPzln37fCvv9deoB27xuaTq7R3gdkIuBO5CoQiARBUq58AJVP3V3J6frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFCYfeR9VZAbgwxrgnyTz73UEs+FAZWX37DjjUGzNIQ=;
 b=IHn87dG+PZ8NpCY/9wk2vq+PpIKbP1ZCPhV4ob6bumSwIQuWDknlk+oWLZKGpppCw1ZjOVujUvmr/Nypa5ENc/89mrv8IIUVlDkO31CSJedQzyEWAlVXZRZBqvH9m8gjlHyspLu3/0KYS/zsrZbKVtGe1+FQHWqXlizbHSiGeYv3p0VkP0IxI/5BYFBtze2Atcw5SBX2XpcseVgAaYKs/21UbmMHdKnz3hw7MIqN90iNHQpdA0L/FS30L+atbpccAS2vnymftQbh0AV/E7qzbhuraB3AanZ3A8Otd0fgrIpb4c3AEssyWIGfVJ0UhF8k3N8GtmDBf23y6ghNuNm5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFCYfeR9VZAbgwxrgnyTz73UEs+FAZWX37DjjUGzNIQ=;
 b=gc97k8m8mTaS8HwvxNdoMXce0p6IMP87yt1hzAZI7hEUOiqhMIGoTUmIou4w3ULywc/xVfJgDKfRceFwGJ99t7Avr7VuFutkCTB1wO0udzu0Voi3RYAfR7upcCZo9bEu09BH5cMS7Jy2yT71pd+jUJ/ng8KkYqYjPxXHvOXmzC8=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6393.namprd21.prod.outlook.com (2603:10b6:806:4a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.2; Tue, 18 Nov
 2025 21:18:47 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9343.006; Tue, 18 Nov 2025
 21:18:45 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "longli@linux.microsoft.com" <longli@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [Patch net-next v2] net: mana: Handle hardware recovery events
 when probing the device
Thread-Topic: [Patch net-next v2] net: mana: Handle hardware recovery events
 when probing the device
Thread-Index: AQHcWC33Blc6Mk6VP0GANQ/jbxrVFbT48UVQ
Date: Tue, 18 Nov 2025 21:18:45 +0000
Message-ID:
 <SA3PR21MB3867EBEB065D328200DAB1A4CAD6A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
In-Reply-To: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42649ba3-361e-46fb-820b-0d04306f2a81;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-18T21:17:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6393:EE_
x-ms-office365-filtering-correlation-id: 9615c2b5-150c-4337-9e72-08de26e80ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wfXQDniWXhLcCEC+2k2wXMse82SjkJ+Zu/OmgyADnkaZIriys1OwKJl9EL9n?=
 =?us-ascii?Q?5dZ4VhmvAIAvBscaxK/AXCqKemflRad0/8uhGULUVgKYkW0eLVi5zK7mF9US?=
 =?us-ascii?Q?QHy0Ft67BkXGFGjjpQofAdvgBrOP43uD+XMC1RNegwJQ5bZbqjM7tPb0HaTh?=
 =?us-ascii?Q?rOv1AcZw69MnjTOgq8EHf3VLuEALPCoCwE4RmKan6OHZgv6Yoq89bEOe0Pdh?=
 =?us-ascii?Q?9m2+LZ0tqfWv9P7QZLFLPpM04HlmfREHS0ba+Y/ot1j7kMyVJOGY2CYZMZQd?=
 =?us-ascii?Q?64gzRBLK4qRA+gJ7kDqR1allDaC8YLi3nubKopJ+4e7q7XM+DXVwNBeVeckn?=
 =?us-ascii?Q?pgAAJDFT68TI/ixETIw927RzlS0LdpFYfmuPnbCdvpiSLga325NoDRuluZ/h?=
 =?us-ascii?Q?t+uKdHza8G1qyqDNJdXPVdAVjqNCYw2V85u5v5oaEDALh8se59forODGFm2C?=
 =?us-ascii?Q?jxBjnP5wn3qwU2RnPJnoOf1rlUAajOzfclUpSxJUTEvxb4sVKWi0FBJBp7Ck?=
 =?us-ascii?Q?vWfYTecpJMQCtedbruZZy73xPG1V4h7QGmiCzWc1OrodCXPJll4pmpgpPlUa?=
 =?us-ascii?Q?MjfhuzR0mfPDheiJZkErLCrN9wSm+Vvocuq9Zl+KOtD7nE/8VUAHYVYKjCcR?=
 =?us-ascii?Q?V24ragrSHxsyLGgNw4GDCIgPYQ8ExUdQzemY8VI5/UW7RK9AP754xUzjY0yq?=
 =?us-ascii?Q?Q2jfK1JeS+eNAsE832I5QsVc2samLVq3U/yJZ1dTkA9QpqkklIcWVPGXmfDA?=
 =?us-ascii?Q?OTzMVpEdXJQsiTVQqszouNAAp4d1z6xnSenGgz8sWcshb3J7lLXxawdDadPQ?=
 =?us-ascii?Q?M8wxWUFBv8OwDkcqxfmHAzDdongZOvqpzLCnJzEQJwS/XGnHzFjAoQQv1jo5?=
 =?us-ascii?Q?93zgwnu/dKcYEfCROVu3jYCx19/IdeZKkEpVW4THBakBGziBrIn/6yUtZNP+?=
 =?us-ascii?Q?Uy7pO+BIsy3GPvPbyhHm1zuF3NQ98eXZHMhGmhETkbf9UgYmYwgcNz7wzVVO?=
 =?us-ascii?Q?sabSUH8llxnsm/B7BuM4fxqMor0wQ9gQkoSsF6XfzyqFXoZ+ukJrA+okrGsS?=
 =?us-ascii?Q?dS4RjqugzrVsWxy/s4nDCRy4Mo3xwEmR4gSh9dzC6ARMviLgxyAKU1NxGrRE?=
 =?us-ascii?Q?XT5S6aKpqiHfIOgG1unnIaWVGYSg06UsMNpbuMr2MOFcyyIK5vEQnaSPId8q?=
 =?us-ascii?Q?0OL6sulu3qh3nMfDVYeLPKFXd2Oef+N3RG/YuXiMWS1VVr/s2M89fX6jwpJS?=
 =?us-ascii?Q?k4EDQcnbkHTy8Wnw+ozWopUTBJGIcSVZ1deadt/l6Et2RJZ2XtqMcWkJIjJO?=
 =?us-ascii?Q?g5eTLBYY+dQSKOta51EiRuACkDuCahDmnoxqEdb6oIs1uh/xGjYXoJxm295I?=
 =?us-ascii?Q?pgW8YltOa9ZH2dSmXR5wf6QnIHL3X/N1XzL7fBTHMhaNHPaIdw556tUXQ62j?=
 =?us-ascii?Q?rsgWPsuNgVvF5BjdGzJs1cSWGf5oaB5dGL/OzV3CA3kjGwNgHP0LbLLt86vV?=
 =?us-ascii?Q?2RLcMKEFm0AOsZrjzLVz0GBdUsiVoN2MpwSFf0J0cGAww5Ib+E51787Z4A?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8GhNcTFY9FuiK+Ub5fLZK5gMZJgMXIHVbpRiUIPL9AeWFcj0veVhwIMy9KXO?=
 =?us-ascii?Q?4jpihTWWUJVLwdDqk/RHjrrFe+JZclZ5PkLAXSPDdM29cF9IPIZz2wKyOnRw?=
 =?us-ascii?Q?fK901/ABrRzo4gU6gl9Dw9hxN5zu06yM5LJCYWub6JfSH5CI5cvbJqTpezH1?=
 =?us-ascii?Q?EN1BwcoTCo5hLBtmcCwpgND70/tW5rZV2Zxayp2TQ7OgMscHvXu5r0+BR7ST?=
 =?us-ascii?Q?ZSnrTGaCdWk0l0qBp68SL/JNj4hWYkrFzyCd7BcQ/bx7HRHOeKlP/5UHrp+4?=
 =?us-ascii?Q?Gj/YWC1sB6UIsCnNtj5iMMYkpvURWaxdsCfrsaKDYCJTfmWhhRPxqhrkyxU1?=
 =?us-ascii?Q?aWSGCkCQ1+Yu4d+glikbsA5NFoKzShnzp+TjHiBt+0ubpAytbO6QJgxyfjjx?=
 =?us-ascii?Q?wJQ/krGzN6DwkIe9yXO63+TR85EKmKLdBWZygeTNu4gCalnVoN9YACy35kdX?=
 =?us-ascii?Q?MthwE1hnZYWJTNRbZHeY+lFS6lsA3kORSpTWt0kZofGxSKS43fdh5aU3I2+G?=
 =?us-ascii?Q?xLU0BZ0v5nyc3P0/NjrgyA3mjPVuAdlyM68bBgX8KzQTjjyHPxiNnNxIorKV?=
 =?us-ascii?Q?NKj984qw+J8KbSzDUZwbe74aIO6mIyOI8SHJvFVCe42LVudwzqDiJWhIQ9E1?=
 =?us-ascii?Q?8sxlsGLPQd3YMC+e0Px8om1xfZX/rLMDRLprBxNJu9P+SyeVdibAu4rAIQTN?=
 =?us-ascii?Q?PhwPO4V4SzhX9dDVHHcMjdm4+alXDgwt6Rnwb46LkDhd7tyPz7GTny9NKNUm?=
 =?us-ascii?Q?rPSfT74U5pjf9por74SMqP8CmSZ4bUSPmuAQW9l3DfyQl71GDIQv8kxaAkUW?=
 =?us-ascii?Q?VvkWZiDvYb8hZKkJHaZmuBPvesZSROP1hBvIDgys5p5OVh7AgUhcfYk0AjwP?=
 =?us-ascii?Q?QOk0KHx7I8RJ6+RV2bgxvkTMz5ZJDQUAtRNDLLoRCkFU2Cotd8wb2Eg3x9aK?=
 =?us-ascii?Q?fiEnUAnRw2oLwphrE/NRrgai8qcTd4rWP+rJoPNJFUrPI2C3nCugqtPI4alC?=
 =?us-ascii?Q?ql/Wqv9UQLt1yQPil1+nMQRyhokjyOqfKtpjNaDrcxsDPj0zCeQca5qSL8uJ?=
 =?us-ascii?Q?itF9t8R+OIwuUjA7daC71HdPW4OnJsdb/meDJlJdoNSuKeVPrmhYQX4UnsHe?=
 =?us-ascii?Q?8XB16Q+VFDnU/FJRi+AX8O2QmB3mz+B7hQpk8I6cFqQxaGFxdt1/7OErJD3B?=
 =?us-ascii?Q?jZ4GEkIPpKy0xUNbJVIPxOD+6ZJormchuRctE4nTqSLWCYRjgTqKr31hPhfN?=
 =?us-ascii?Q?TBWwYmZLol4+tlmNeA6TUCReuwgeQKmSv91n5VZpfQR9EcW6K2XnVG2RTa+/?=
 =?us-ascii?Q?sKMP7fcGQWByRpmaA3wNOPdkgfdZycTTfCzYaIcv6fPGShOJRuDNeXU/jEme?=
 =?us-ascii?Q?1U8KfzUvGI91KM8jx803Dm3+ja6u0oN1bkG53SIbtXZAkDjb21Om10HVEG3v?=
 =?us-ascii?Q?f9sMFUVv3q5FOPE+2d+/XT4C5To19wZiOjgzs5xEyeJpr+eaobr82SiEceG1?=
 =?us-ascii?Q?hI1iuDSJ0SMlQNpUSZB0cWE5Jf76nHLuZgPRzU48bD5OOivOMWvVOXBbtKW3?=
 =?us-ascii?Q?83bQ9g9DSVzfthGDqQM3qJIJbUSf1cL+1MM1D6/V?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9615c2b5-150c-4337-9e72-08de26e80ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 21:18:45.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3ZvENIlRieWZBrD61zqqW0JJ+Z9A3MmpJeq4X9XcMhJGAi38PzrgU8JpJsLaYcHmwy6q0ym+Gn6rDUePxX6bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6393



> -----Original Message-----
> From: longli@linux.microsoft.com <longli@linux.microsoft.com>
> Sent: Monday, November 17, 2025 8:52 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric Dumaze=
t
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Shradha Gupta <shradhagupta@linux.microsoft.com>;
> Simon Horman <horms@kernel.org>; Konstantin Taranov
> <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [Patch net-next v2] net: mana: Handle hardware recovery events
> when probing the device
>=20
> From: Long Li <longli@microsoft.com>
>=20
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
>=20
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


