Return-Path: <linux-hyperv+bounces-2916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC6964C31
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE86282A18
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E381B5831;
	Thu, 29 Aug 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jIJ7uCgy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020073.outbound.protection.outlook.com [52.101.56.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E81AC8A9;
	Thu, 29 Aug 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950512; cv=fail; b=BWSf/N0bXskjVPmKAmxXGBAAMQqEW0aSznkxKS5dbQTDs5dJ7i9K0qMU7CRyIh+XXCVF+VzRqD8AioRjM+GxZvnmY5xlqP/WPNXH4YlfSR9c6yvf8S4P6oaWaQ9uQsx7A54jVP1ri4LQGauZ1BOurladn8PhI9BgzQfmAWTptvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950512; c=relaxed/simple;
	bh=oOUXNxdotTaPkCwFd7L2sAXsf4TGA5xo9OcviAtqMrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3gQcwJ5xad3g6besOdiJiukN1nnozn9Vd1+rj0lLagaTzJ9ib1AfvXqejCuL7gw3+VNHnAGq6dOEE09TBIZITn+JCLfBs0dLY+YdSKlwis9FINsaEzVS4Dvq8XHOIbjpKrSDnkE+RuXNul4DVWX27gfeoW5qqWwjqkbxxIX81E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jIJ7uCgy; arc=fail smtp.client-ip=52.101.56.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoITmMWv7cCPtBgg/sYyvE3zORrBs6CB0oX3hlH6neeB0F/qF+w78xZTin9SwFpfwxyd/KqU4ypJYYJBXaPIUwZN53kuMVE7OrLwbz5OefwxdJHrD0ouliFPJZKtd1lwb4kZSgonxeeoPsBGOSO0zuL/leeEBLMwcJ3yH1jr/44S79jUgwUIfH2VF102SxRTGdLxZjzUbeetCHZl1c/3/0tnVCahMQ1Ufv6HzCdK+qDNvZXr4HbcVILunVCLZA9te39e5WCcijeVxTX2Xzwsxjocgc0OBfO8V+K8pGTNdYZpR3vuwBl6OJ0X9X7NM2vIVI0fsVXnBgNH660Ct1Cj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v91GYhsoC493RE3LbCWVUcrocpGgDNZDDw5hg7EKfDA=;
 b=QNwzmCqDXEEblGUGL9vHhqC51Zq8CQdqoRwJ01w10mpHUR0U4RJqf1YXcjZHOV8goYUYt37gZiwlinBloF/5AGmntxv3RVHzQl4IBRfqdSzzpvrnxKjDFPbXA5VyYsYMRguReGUvEM+YB/+JWFe5xfrk5qUrW6/Ki3vcRNJ97mKbP6dTJhOvn1JNWQ/t5H5aizG+i9MOwcyuS8QMgUewac0SQowL1plkJyOOHSYU24IYl0vMeRoDFUBPT8iABTmmNkSwlwRr9EzdDxcdOnMdDEpRp83QF/LupJql4SqSb8DvDkHnvgwuXLuvElMA7BVWcLDOuWYJ/Z8dczDenwc/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v91GYhsoC493RE3LbCWVUcrocpGgDNZDDw5hg7EKfDA=;
 b=jIJ7uCgytn+FDqteuqNC5PlOJkJqhnWwtir3cMhIgoBHFVH5wLZ2QnYytvCphfhy+hrKUPLswQIPbpJZTfyF5ddH7GfKjcmsu7XNi0lqIdZxNmEdiRDh27Pqd3V7qx8TurGTH2oNHkvzQR/YLj9ciDIWX6olseIVE+I323yDQ+Q=
Received: from PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15)
 by IA1PR21MB3497.namprd21.prod.outlook.com (2603:10b6:208:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.8; Thu, 29 Aug
 2024 16:55:06 +0000
Received: from PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0]) by PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0%3]) with mapi id 15.20.7918.006; Thu, 29 Aug 2024
 16:55:06 +0000
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
Thread-Index: AQHa+e6j7hVwv/g+nkyjJvATfz6ZwbI+dEBA
Date: Thu, 29 Aug 2024 16:55:06 +0000
Message-ID:
 <PH7PR21MB32601A9B8D75C164AF9B18C2CA962@PH7PR21MB3260.namprd21.prod.outlook.com>
References:
 <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=11a9a28f-548d-44f0-aae3-bac4d2dc5096;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-29T16:54:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_|IA1PR21MB3497:EE_
x-ms-office365-filtering-correlation-id: ad6d0147-94ff-4594-f62e-08dcc84b5598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0WIj6lKd9zIk/db8JJvRpYs2LPTQZrMeUnpcJS2tavk7kt+1J8DmI1Nx3B5M?=
 =?us-ascii?Q?4NUzEMXS4b/n+OoLpyql17UBmt5zAJK6n6PjXEluPB5LYxF1y4Jzg2swb2tS?=
 =?us-ascii?Q?2d8Nx3Jp9TS3JrKuLLEy5N0NE8lDZ627M/0kDxifdEk/VreIZ+9k7KqYjrg6?=
 =?us-ascii?Q?UeGB9PMxqqs+N1U+LnBy3AYauhHRr9jIiXXnhyax7DYwGyHgMiAey9NHQwhZ?=
 =?us-ascii?Q?SWU0JpCe/Q8QMT/mKn6pwQGhONjabBoqDc0qPYWSCO93pyCscAQNTvxM9xB3?=
 =?us-ascii?Q?eOchnYlDzVHblmzlIgZyxKtrzOx/qMcSwxnkS7usMAUY2sxRGKIKw3eOVego?=
 =?us-ascii?Q?48xRQUJUmwr5wmM2/EPU4bbbTJ9sXwP/bcSL+ditzwLWlC+wKk+0OY+1aibp?=
 =?us-ascii?Q?jKDSvvfUdK/QLRcKXprXp/xqWHU3N45EafUKvrkXlBb7+hFV6ssThGQbv/4l?=
 =?us-ascii?Q?BXWaF8/0G6zJVxnza5V3E0z6ar+9mNmZjovQULANuoeoKWS4JK1Um51P3bxW?=
 =?us-ascii?Q?USDYRNdfa+5r2/euWIyvC2uglwqZzSjcrv67sm64nCmpd9l46ZkQ8NQM4czm?=
 =?us-ascii?Q?5W9HQ+pbS77xyFt70ki1QHrFgmYUxi4l0spKcKXAT5oRAeIJ1J2S2N6N/1ly?=
 =?us-ascii?Q?AbjNUOYugdJ00ZQ9oSvCNipcgxI8oQkPTSTwi+KUW1DG1mcyAYm3uSugkJdW?=
 =?us-ascii?Q?YgdgyCqbf7+ISt7VGVbD6/GXP0u1GUS2LldWI7nrZtMq8kCdIl5o4TJaUXmM?=
 =?us-ascii?Q?Jf2VBXSdKaJ40+O+5fpYakL5s4CEINEy97Nf8m3tdg1S3mjXzyg50QnKOWlu?=
 =?us-ascii?Q?s/0cTNbtm98Kuv6DCBLHstLs+CvL9JeUzytE1KRf+mqJ1HmjrQG/erxF48/p?=
 =?us-ascii?Q?acaKC2IYAL7geQHQF7/TNRC4gLjAX9Hf0Rs7D9qIy4NtoMZ9AqmvkCf0PCO0?=
 =?us-ascii?Q?Ed5t8Ivjhaf8ifJrjU67nudZP+tJUWA8hvbO7EXJHpicKwrB63aOowYtKS30?=
 =?us-ascii?Q?vvAb4quDPvoPmcvGb4Xiry5oOSJBIn5VvYiuYtZMbYFjIg1FFEHyU0zlWobQ?=
 =?us-ascii?Q?sFTekDRTMINOI3zOm0fFDQAsyby6ZiaNjocwJp6HhXAUPB7HFURLewXwZhvq?=
 =?us-ascii?Q?CmDt137w+J/1iruHMTUU07H9DIV+ijf6gUjQz8WRwjnI3gq2q2BoRo6ziCm7?=
 =?us-ascii?Q?voGcU3xNxFPoHc8zgX4FjG6r/Pqz9jylOGVF30wKqN2VbPtxi9J2kD6SsSN6?=
 =?us-ascii?Q?ICAhGnMry89ulkzeILmdM9NPWnKFfyGp3XOJ/jum74nm51tPZ5TsTlF9OmC0?=
 =?us-ascii?Q?oT3QmEC6m/GtSZWi3RIugV+0Q1xCqnnYSHhbtWQRpPnU86CN/PrLYtdvcQ3u?=
 =?us-ascii?Q?ep2SuEn8lUaiA7C+3Q+0oitpHEPr2WqH9pxVJz4I0WjKCuqC1IaFw8Edweth?=
 =?us-ascii?Q?3ckriQ0uK1Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3260.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kebdvRvPDNpXg97bOU+LKQ1/PXCL4O0i40j7LC5G2ZlIJC2QAFhWIydhstNB?=
 =?us-ascii?Q?rwAk8OWY8JP3ZOaKTUs6asazjD7li5mXABRdOBWbUu8tTxYFr1go+EQ1n5UB?=
 =?us-ascii?Q?760HcnCWFoBzG1olt3IyVchcDKYqkO0si3HMYF50bhMNFkT483oG+lAKq2+H?=
 =?us-ascii?Q?fjufH3DyWbXiVYp0WR3ifTA7DQd1FeUp949TeGOlvFv9fw5NwZ3TkH6tH0cB?=
 =?us-ascii?Q?PfzZcLZJLB11bMeD1zSlkZ3nd+IlOJVc7GRgzuAeXRRWfuMgClrfXL8hCJGA?=
 =?us-ascii?Q?9RLjDJ8yV0j6PjDXtNVvxZJDcYzKF2XjyJu6cqDPKQodGsIzJ9XQduCkfOIe?=
 =?us-ascii?Q?PNp4dtSMhUVy2AxjvtNzdCr//e9S1+qh+zqBYqYVPQuz4niEfUQp870fWEX+?=
 =?us-ascii?Q?IXWn1gHXMzVqZg9obCeBCqe9lnR8O1gdyhI59RZl+7z2rDs3MW0G3QO8reN3?=
 =?us-ascii?Q?m/7U+ij3tuMe1dgbB7UTjQAwdYB+2fNu//H9ysltLAy1s9lBVfIG9A2YUl1j?=
 =?us-ascii?Q?L5/2dq3+k+H40QIT3PI8bsLO6AZX5g6jH+A2FKPe7oeHbK4GZPhMPy7ldW+7?=
 =?us-ascii?Q?V3SZddUA/Nc8zBYky+rdKmkgRfOcAHlHtpX13sEOGOepsAznxwJrcN5lwvYe?=
 =?us-ascii?Q?VkemPrRMWe64Yrr2npy/UmlvA0TUWs/t/nNx7BubmLMvDCMaCO40Sg8V5gtT?=
 =?us-ascii?Q?G+SqinZkIrD+0tc6Eo4GrPeww7MFy7eMfeSPHKY/y1o0wctP1LCBXgPy1QMR?=
 =?us-ascii?Q?PnhnUKg0G2yp3aav/hQOCqhOeC1FIrYjpgz9JiMUrWW8ol7YeGgV4HBNMbgU?=
 =?us-ascii?Q?WUfvKgcVptQiMFi5jMK0JOmdRdaPWaZDs1wzxtVwNp9buuMiZMusHmdakrmd?=
 =?us-ascii?Q?VyDarmScHjpSZ7O9IpYsNIls8cy+5MqrLkOO14lfLZ4iIJjTNOJz+71Rstuu?=
 =?us-ascii?Q?x4uKwWhhtseAFZQ3FBN2cNpj2EDxAE+MZQe+SFnkhgvPhPUhiZszp4jeO02k?=
 =?us-ascii?Q?4DH6maU/GeDwm4PT1EyA3NqAzlFska+Lj/WfUBi5+naFSGpQ8llz+DNMBM/R?=
 =?us-ascii?Q?JV8OCqJizz4ameSBCpbOkrmJuIZ7QEJQUx7tbPNFJvpq1YySKHMK8XXxHysa?=
 =?us-ascii?Q?ANdxeOlRQOPxfsPI71QqX77GogyueVe+Gp5lIWHNpZ4lPoQHGtlidkvxXp/v?=
 =?us-ascii?Q?LmDNj20ewere78QnYoF1o2OtzXKTrvExOyozOD9fn4YuVe9q7N8xX3Yu89M6?=
 =?us-ascii?Q?dwgnduSa8ckv+xX8VTQ8KxST9vEKuGGenN3jDq9Ia6xEfLhFq+od5XEEBiM6?=
 =?us-ascii?Q?/BWIClmc+Mpbl074YK0XK+oyidowuoXATM6vKLqpTsmG8fWBzDCD3kil9Nkm?=
 =?us-ascii?Q?UIne08nHF7ESiX+p1Q9Oqg0r52AFJz0YKHNhC90Tn9JfV7qqHyK4RaDEfrb3?=
 =?us-ascii?Q?wWd7cN1K6ZJldSIRYs1uIzzDr5qgjS6QuKrBszmt/y87sUrkWrj1EFF01UtU?=
 =?us-ascii?Q?0TzJDUhhd7AAyZ1QBI03gjkGLXetrEmLkQXpFEIdMHe9X+AUXlMnNG15ipQY?=
 =?us-ascii?Q?kwc2OObd6bxiSEpIQAwdZFUkLitMU37BECj6AWp/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6d0147-94ff-4594-f62e-08dcc84b5598
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 16:55:06.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5cEakG01NZjvHl9V5+Sc2oXmtLMXp4jz8l4ltgs0UII0BGcfBNhKmqePtAdUHH67adjA/hIBhT9D9Ag78twUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3497



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

Also, this line removal is not necessary.



