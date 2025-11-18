Return-Path: <linux-hyperv+bounces-7683-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159DC6AB32
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 17:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4D053522F2
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5223817E;
	Tue, 18 Nov 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TJ7pEu8O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010021.outbound.protection.outlook.com [52.103.12.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574C2D5C74;
	Tue, 18 Nov 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483339; cv=fail; b=G1aK0QB1YXHG17KuU0/gmGi+mJ3Mn6IfW1c46zktLtkIOTI5YO7ZiZ724kBRYjvhUSXVrppnMnw2IL+cVgkdIlWOuliBiE9e+xt4O3rVrflw0CpxNZudRur9zOapH63z8JRcNcsNHIS7e2N+tuxFAD4POX5arB52ULzyYFyOdQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483339; c=relaxed/simple;
	bh=dvKVyUsmjw4Z113zYoMni0OhuR2IK8Yir5lrrTO/6SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8ZFoa7uxSnvx4v75AV7chdPTrOBWLlZAnNK9X43Q9satlfiDARnsHE9SNrAdsAREk1afRJPVhgtpjEG+Qk1kblAvtPtFwXid9yCVhu7Svy/Ut697us3Z1tw8r/ldPhcyCAhIS7SiASgpHUEk17e3wEllEEWIifda/Km5EQpNVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TJ7pEu8O; arc=fail smtp.client-ip=52.103.12.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIzclaGqdkjs21pWwjvDJrfS17PIdvOEZuulnQ2w2vK55vHUuBui6QNrO44sLIK5suhMsuJKSHntemtxsp7Jcm+FPnzPazC5KjzyurWj/g7/KNlJcONQ4Lwf9hvOU/tbdgtYCohTYhRRBJuF9fuB6tYxiJMZ2QoZs4TSipxJWb9O5nLAjN7LO840pcSlfpf6ArPiFsxbQ46UdtxyQc07Spz5zCEwQ5HTMzKclQkGUBjg8pRPjI6r0QHTV5Or18wf742S86hcberA4WrTF4XpyswiWHRlzAzreuyCkQMbE9B80BHeNsRaNo/Ov67W9hxS1BpivgBkgh8J6ENnE/8Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abzEAt6cu1Nt8avDUfGSw+Q2lLPXnogFbre9Z3GIanA=;
 b=vTOJc7c9vBi6sJjvKYrMk0YHH9ErcUkiCO5b+gIk6CzK2V0Ry+kM8ibCxqLEbusUNZHpnO38vsQqRgWdD5mpIJqS6/ib5l1VdOkYegkLqtYFUPWZ+b5S5CDID3m+NEKCHej+5zgaZs99IcWJqstnGAQ9g+fNbPKTXUJsa3F2sip3p9DDUDkon0VrLmQaRpFNd/QtCW2rUCsAQtUfVJoTwxzQZtwNgpGanmxHqKh+zRwDo3hnD1KnXWnQSmLYzzLmP7ntgY+i+McEKhIY9Tac+ElIsiOa9dGNTECrMSN+D4rdGbtCgZWuMitWm5hNwYkEP3ZAopGPpMj/K7EuwPJ+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abzEAt6cu1Nt8avDUfGSw+Q2lLPXnogFbre9Z3GIanA=;
 b=TJ7pEu8O2+9NhlKVEaD5W0qr4JnwDWXCJo0xlFPOKXJrUZDq7dSOZQSkzkX7/aD2tjiXeKd85DnZKe3Wc5dK1u/pc/f3QkcXROfvqKlQO/Kp39K0P6u/BPA3gsiPgdtaJGYhgPYB9WuVGwERqXiEI7dYtkDeM6C0QpHMyXvHprw9ZW4cS8HwLDROHouWM1ouJISNsMCP3U5a2pwRD0rrVT0s4kTyGRym6BwhRb5kSClrNE/TAZILl05WPR2j4pCGmmS9WnYPSUQxaCInI5abUkQEWNZKeb9lvK4pAXaVnEj1EEf5bxDejQcU1hEq4TZxPNBfql6FyK6kmmiK30M4wA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7848.namprd02.prod.outlook.com (2603:10b6:510:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 16:28:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:28:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
Thread-Topic: [PATCH v6 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Thread-Index: AQHcV+PdVn0hTcgXjkiYvKJmDoVGpLT3Utow
Date: Tue, 18 Nov 2025 16:28:55 +0000
Message-ID:
 <SN6PR02MB41574B72041F6AFB1B83DE36D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176339836892.27330.9465609709535892557.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <176339836892.27330.9465609709535892557.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7848:EE_
x-ms-office365-filtering-correlation-id: 308db6cf-29e9-4bb9-50b5-08de26bf9154
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc8PfaoaFMUNWZKRoZ+Te3QAIxmXsW96QxyiCim7w7WbBJr1ZuZPdzN6ztEDvE3f/45mWqHgCnTJePAFBh3dv9kmNJNVEgEkzRD5ruo+4K5gVxBNBKd6MqU7zvrf9kyOlz9HH6AGGHxTMnjoOjop8Oktu7pNGVkCyIQ9QHxqzYGgbMJAbj2fY6+bzX7KaCe0IBxILtAeUNeGyl74YZ3+5tYvj48lwkaL1uS6G1/x6Go0b5movD+lcLCHeWlOdKuiIWg/UVUL74joAiVlKcnjgVGPggHhAIIBXM072nJEg/893VsCBNKkOF7udxvODJpycKkY/XAPFJVzAwlOGu9jAyQteH1LxGlvT8qy5OHYNqPshKHD2f1o5bvBaNNGEh/4biWFYXB7ps/Pb3alxyMfu9lGM+kNKLrm8JLtrejvbJL0jtrqtpdErKjJJpwdtYJKbfL2+R61y0KVmZd58CEeM5ZDw8s8nYpM+QGsFGuu6DYZJS7shANghwHCnfAcO7kvJNfhPia5kYDPUNtIKSQgOdFOCaR75GCFwMxcAyLKfrdvQVawRmcEkhcm3zdvN0Gi2fLPzhCQB9WMqVqxK2Qo24hZI4fT+d7MmEkS7TxFKUCAwpdIubLXEJfh8p8UDtt+/o/Tqb7tDL36NGQozTonV2aMKU6ilZHPrc7081TYz60g9vaRkJxgSZ3m0SwYk/2uHsPi2kd0/NzTH7vBWAjbhe40TIQF00WhOs2HTsyRRKLkaiTFqijckhU
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|8062599012|8060799015|13091999003|19110799012|15080799012|12121999013|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G9wryOn/g7Leg2VXTL6vHfQkr8xweLjHqOAdWzdL02SUCjvpZWS5vP+EI50K?=
 =?us-ascii?Q?+ZUfsK+66um1RacpSG9fkdwDj2RIKDCR9M3dZoYQrinwwga8jHO1tHVoPw+5?=
 =?us-ascii?Q?JxGalOwPSTL+CamAkZC/WuuIU6SNbesgI9P5rRajwpX7bim8Rp4JD8Orw49p?=
 =?us-ascii?Q?UGNcctvaT9RR7prLSTzVFcLJ616lZ8WwB5LPCrzFQIPeYw1OlqBPTTiiNN+8?=
 =?us-ascii?Q?LZ/Zjk1odCeEbxbfUaajH7p1hKjG7pduDHl2glr8uDguHrp49auizPUyLnul?=
 =?us-ascii?Q?Js6LLST8tVmhWavhpG6Lu+3P7Dof7f7QsYLZiSjUVDsxy3KVKHBUB2XsdUtT?=
 =?us-ascii?Q?Yon71GJ1VHemWkTBJIfVOly4H6iokEAk41ouQUEZRV/k2KGg7+dGoLUiGwu9?=
 =?us-ascii?Q?Vm6QDQWkX4Oq3KJhAHoPEMI0oR1Z9sSs2KcDwbzb2HnboGC+HOHe0Jfen90+?=
 =?us-ascii?Q?OCWb247iNTCjL8EYTyMRyhmtWgo6AAeoz1zIK9pFVCys6qvTcOY2JI+JntTy?=
 =?us-ascii?Q?2IurVCycm+3NQJuZjok3xsaEnRP7Drae5hU0aX01P9YL634y1r2igRJIc3fT?=
 =?us-ascii?Q?DPnTr/0JjGFI8ZugjuTJsIUkwCN5Z5XCcPx9THG2O3bbSHMuQezrk2uEB0r3?=
 =?us-ascii?Q?vSH+YOO7c8EujXLfNt2p0AytI7Mu6rnQMd/fOHyUVRv/p2lU7JjPMrFHKDA1?=
 =?us-ascii?Q?G8bWv5WY7rRLwI7dTBlp3TL1UHMJU2XqWN4lLAxX7EJPKjke6e5WYQ3QGrta?=
 =?us-ascii?Q?TehUCDfWv8WwS9vdJmtO3Pj+3NQMmwsYGRyL9a3ifCdE2THFFRyL7CkEgBKv?=
 =?us-ascii?Q?z+/z+8YC9mlkUJWhiMaBlhs6A5PuCZ1rdECVN/hJAzB1pM9nIJxGChRpQudo?=
 =?us-ascii?Q?ZA7hI67U1QEmdFkCRH/zqJRrZn5uAry+g81K7KSGn+FXcDF7ut5lXx5O4UFu?=
 =?us-ascii?Q?rpPf0x4KsPBUgB3WzBxj3f1pg6SjGXloIR4O+C9/R3irq+B8Ii4FvPsLd9lD?=
 =?us-ascii?Q?xMEgaFJitBFavuxCeS276vXbLDfeHmdOZM+2mWA/rbS/3+NPTPmsgQoSgWh3?=
 =?us-ascii?Q?2QdVOH+VbtpFOYlcsqzvu45sQLnkcQvXyGs8Ywa2LCwKYLhgnHoRh1wAl9mC?=
 =?us-ascii?Q?JMATz+0NlLdOfy00eU5NWlu31Mbv19SewtnTNR53UUPeKl6pYQCftbdmApy2?=
 =?us-ascii?Q?nvdDwps89e6PrxXJGFmcmEve+hmeVCQjm/XzJzyH/UFSp0A20Fw0TFraAa4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HU2FR17zU8PHXh0FrHvR4X4sAMkpdH9pvqhQnWB3fxhUs47SgjORWqTZqUxu?=
 =?us-ascii?Q?KLWM2/KOdLe6qSJEZj93P2ndOdh7oTaEMAZWkbeHBtfmRqYyVlz4tBJo5qEa?=
 =?us-ascii?Q?xUYJmF3ZXV+7++xm+pkMzB5+X40NIf2iFE2IC0B3Bo4IpbLdqkD2s+LswqS3?=
 =?us-ascii?Q?anjASbDLlvNmcwAK+7aX8CN2uny5emNBvC23dhxWhKjML9lZhsINgFGSg/an?=
 =?us-ascii?Q?r+H7DNffUQgoGUZxYu/BouTiDCryahrIp8LpbZrWzdEWftrQnuE8fKy/u8iY?=
 =?us-ascii?Q?D68UQmNNb1UYGcQEUzjs3DhX0nk2VfBYXKizbwoWVGsbGwfeBZ31mdMVOVvR?=
 =?us-ascii?Q?f9Qdd3S21JxifJjzgcGlit+/bpKNAh9roaSImF5BrEYSMUXeZM2LMWroOahs?=
 =?us-ascii?Q?n8Xgqe05Ih3C/7Y3oXxcGpGKcp/gnu/a3kYrzG8iPTJh3JXBsZqzJuh3AKBe?=
 =?us-ascii?Q?LHanld58VGbRuqvBUVjztrOZcg1F+nUvNAGRfyNDV4O+cKYTBkhZdY2lhKA9?=
 =?us-ascii?Q?0MC/3bU+eT/9fqv4lPV2Ok6c/DpyBg4Jh2Nk2qb+ppMggv86HMzOK7SppaxO?=
 =?us-ascii?Q?ehB3Wk8oBs8SeZHP2FFHUB9cpFJnWKAv/RVm9zL0LOEQHXktwtyc5DmqQw4o?=
 =?us-ascii?Q?55qnc1DFUNoDxAoh4l2L+aMHyx5pLVKav0ZFO1VbOpE7c1YnEVY8GBUa7D0X?=
 =?us-ascii?Q?UUS/IBT/3SiGrbANLDeEhLQ5YHM1AeT4a87CAButnoRod7b7q5o6lLLb9Gdo?=
 =?us-ascii?Q?5cRD036TzbmPJPxdnWFZQb+0AxZ0VNI2mTBDr30qcjA0FPi+nLB/iY+fdzwn?=
 =?us-ascii?Q?1TkiZAEM+hcj+ncKJ18rU+2bciKJdqYB4CP7Fs3iZ7RJKpKPVvAeASPuk88u?=
 =?us-ascii?Q?yaC7+X2oUUfobNtElEzfktZzcviLxV3fVPwmphPzCjghLJsvdYRtT+a/o7Mt?=
 =?us-ascii?Q?AZmyJnYc5UEiCQFT7VbyhMVwy9f3Ip9WUhG8RYUG5g7+I0dWm8cxqmZKhwKx?=
 =?us-ascii?Q?gWLCpV8XBiNm5wWbOP0um8KAvLdMl+djkum1VszBg1QmVUCmsZoCywIJi0aE?=
 =?us-ascii?Q?yrbfyltLMz5uY0J2psesRKMCPLu+J3bFu25TwhCS0mU0AHI1VPlnVCyK1A4F?=
 =?us-ascii?Q?DAnIq0okzu0NU+zyoja/pa1VeRJfZ0A0X+2mO2Zqhq8yS0zpXiRbnkoE0a+J?=
 =?us-ascii?Q?JQyb77D6ZLEbOw3lbGraoWjycQE10BBEP4ruRtw/Wsvz2OcdCUJAXYTZ6jM?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 308db6cf-29e9-4bb9-50b5-08de26bf9154
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 16:28:55.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7848

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, November 17, 2025 8:53 AM
>=20
> Reduce overhead when unmapping large memory regions by batching GPA unmap
> operations in 2MB-aligned chunks.
>=20
> Use a dedicated constant for batch size to improve code clarity and
> maintainability.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |    2 ++
>  drivers/hv/mshv_root_hv_call.c |    2 +-
>  drivers/hv/mshv_root_main.c    |   36 ++++++++++++++++++++++++++++++----=
--
>  3 files changed, 33 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3eb815011b46..5eece7077f8b 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -32,6 +32,8 @@ static_assert(HV_HYP_PAGE_SIZE =3D=3D MSHV_HV_PAGE_SIZE=
);
>=20
>  #define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
>=20
> +#define MSHV_MAX_UNMAP_GPA_PAGES	512
> +
>  struct mshv_vp {
>  	u32 vp_index;
>  	struct mshv_partition *vp_partition;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index caf02cfa49c9..8fa983f1109b 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -17,7 +17,7 @@
>  /* Determined empirically */
>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>  #define HV_MAP_GPA_DEPOSIT_PAGES	256
> -#define HV_UMAP_GPA_PAGES		512
> +#define HV_UMAP_GPA_PAGES		MSHV_MAX_UNMAP_GPA_PAGES
>=20
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index a85872b72b1a..ef36d8115d8a 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1365,7 +1365,7 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
>  static void mshv_partition_destroy_region(struct mshv_mem_region *region=
)
>  {
>  	struct mshv_partition *partition =3D region->partition;
> -	u32 unmap_flags =3D 0;
> +	u64 gfn, gfn_count, start_gfn, end_gfn;
>  	int ret;
>=20
>  	hlist_del(&region->hnode);
> @@ -1380,12 +1380,36 @@ static void mshv_partition_destroy_region(struct =
mshv_mem_region *region)
>  		}
>  	}
>=20
> -	if (region->flags.large_pages)
> -		unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> +	start_gfn =3D region->start_gfn;
> +	end_gfn =3D region->start_gfn + region->nr_pages;
> +
> +	for (gfn =3D start_gfn; gfn < end_gfn; gfn +=3D gfn_count) {
> +		u32 unmap_flags =3D 0;
> +
> +		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
> +			gfn_count =3D ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
> +		else
> +			gfn_count =3D MSHV_MAX_UNMAP_GPA_PAGES;
> +
> +		if (gfn + gfn_count > end_gfn)
> +			gfn_count =3D end_gfn - gfn;
>=20
> -	/* ignore unmap failures and continue as process may be exiting */
> -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> -				region->nr_pages, unmap_flags);
> +		/* Skip all pages in this range if none are mapped */
> +		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
> +				gfn_count * sizeof(struct page *)))
> +			continue;
> +
> +		if (region->flags.large_pages &&
> +		    VALUE_PMD_ALIGNED(gfn) && VALUE_PMD_ALIGNED(gfn_count))

VALUE_PMD_ALIGNED isn't defined until Patch 4 of this series.

The idea of a page count being PMD aligned occurs a few other places in
Linux kernel code, and it is usually written as IS_ALIGNED(count, PTRS_PER_=
PMD),
though there's one occurrence of !(count % PTRS_PER_PMD).

Also mshv_root_hv_call.c has HV_PAGE_COUNT_2M_ALIGNED() that does
the same thing. Some macro consolidation is appropriate, or just open code
as IS_ALIGNED(<cnt>, PTRS_PER_PMD) and eliminate the macros.

> +			unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> +
> +		ret =3D hv_call_unmap_gpa_pages(partition->pt_id, gfn,
> +					      gfn_count, unmap_flags);
> +		if (ret)
> +			pt_err(partition,
> +			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
> +			       gfn, gfn + gfn_count - 1, ret);
> +	}
>=20
>  	mshv_region_invalidate(region);
>=20
>=20
>=20


