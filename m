Return-Path: <linux-hyperv+bounces-8974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1iPwJ2UanmntTQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8974-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 22:38:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F145018CCF6
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 22:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F6B301700A
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 21:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653133DEDD;
	Tue, 24 Feb 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="isG/p/sq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021072.outbound.protection.outlook.com [40.93.194.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FA4317D;
	Tue, 24 Feb 2026 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969123; cv=fail; b=hF9n2n+8BQyhIlYZU69NFdorEAyvjkze3nEyvGjWgFX1s3BIyqmLHIqKS0XjcE3CJLUqy3Qj6yMdeStj+xA9CSaGCHnxUqUsNrmWXM8LpPOPnyLIxc4xvFLwrc7OKsoFBAigD2btUgnD0fgieoSz4m9gKrf+LB1wVRoV5IIiKtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969123; c=relaxed/simple;
	bh=+lnR9Ey38wCdP48my0KLfjEdU2KZ9uNxli2AXEl3Y1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=opA1Quj0PmD4EOQdCQ7kqFiGOOKEbnZCn47isJSk+De7KOm1oOv1nB4IJS7VpVXui8sknEzH1e9NiRhIwnmp7jxi4Au4GD1rZZ9W/+VxGlJIDhuD7TDs48Bs6eS8v/36pzy54+mP+OwXOY2oQ3PWWcg18jK0lpV7SEZndyEVMBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=isG/p/sq; arc=fail smtp.client-ip=40.93.194.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtnG+qNrVs2BdUuehreCbyt67UP255mnlbx149JteX8r8qS+p2p/ntAE7R2zTXir0T/gkGPYYjVvDQvmoBDoanWF16aV/RoRpqrIV5LynmMzBdZoZRayovrsrXV8As/J1wlZQR8G+yidKxg5dLGknY/87YOqZuX9bnnYIuht/WaAWOUXr+Ij4q7eHMc3TCBZW9axMz0ZD+qHUYEKtCb8a+fNL5pUv/sao9lM9WbGbpCiM2/OYn3XTkUULWNMT3upSJ+eHFdGkWUTv/dwIrhBPpBWljP2f/I7tczMQUx4YHrxTWJwbiMItwcIGRGSoyMxYZ95EzBL6KSF5TTuoC4uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oss7tezs9fYkG3fyAwMxmzItGgSY6HAd14hGKIrxuBI=;
 b=HnhefzmNiT4pd9ux4CB535CrsjFR4+0SKM5XiD3e1JNBBTD2Y1HN8Bpes/MK6jeJq1smBjA8qZu8nDaS9hMpkEEZCq9y8+w8dwZRiIsdbOnpdGlZwOytRHyY89+i4Or5jd5aOVhnGqnJe9VfEaJpqGlTji6/vdEBARBJeHtne2oS1rIZDdbrAMsyYWtzINSJLwVQWHIqBV5XuEbmsnnaE68PVBbMSpNv7JMdFHXyhu2B137SmNbd3JtQYa4zhWlE7K1+9nzTnfqnSMqfwz3pO/+8rk1rsz0VyZP5Q7bkHJdVgPEZ5IJ7qjJn33Ei6G1Ii7Wix8MTSHwZ866KX8MlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oss7tezs9fYkG3fyAwMxmzItGgSY6HAd14hGKIrxuBI=;
 b=isG/p/sqgmjtRJ+bPU+ZkbxgPcczbh5am8UBG1+jCGjpgdQ8/jZRoV+6DGsRYfb+uZUDY8hRq65zK3mVhiyzYIc5b9kBnX+zgx5lcYL5AZUTyurfz2S/MuMf27iMxZRLEMdaM8M5d1o2nt61NKRTOJZ4+yalfQso2ARaaTMVaS0=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6872.namprd21.prod.outlook.com (2603:10b6:806:4aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.6; Tue, 24 Feb
 2026 21:38:38 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9678.006; Tue, 24 Feb 2026
 21:38:38 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
	<kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Kory Maincent
 (Dent Project)" <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
 COALESCE_RX_CQE_FRAMES/NSECS parameters
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
 COALESCE_RX_CQE_FRAMES/NSECS parameters
Thread-Index: AQHcpEGiDcItgSgzW0KbKcdvetQIAbWRpj+AgAC2DwA=
Date: Tue, 24 Feb 2026 21:38:38 +0000
Message-ID:
 <SA3PR21MB3867AD2D324796921228C568CA74A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
 <9ed3ade5-717d-4f03-ac13-40614a0f093c@gmail.com>
In-Reply-To: <9ed3ade5-717d-4f03-ac13-40614a0f093c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50bced2e-7f3c-41d2-98e1-7fabf3868558;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-24T21:13:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6872:EE_
x-ms-office365-filtering-correlation-id: 58eb7307-8ed2-4d79-3719-08de73ed1263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020|7053199007|7142099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AXQ+3KJ2ZUoC6kwCMZ8clhTxnbFJFPaNMkVKciULi1fIsX3VcURB7zrkHF9e?=
 =?us-ascii?Q?4yMBJHZv8t7HhwNU25zjgSk/VPmY/acgBt42dawHhOCPAc5bTHJYAjuer8OW?=
 =?us-ascii?Q?iJN2qWvNYvhmEu6TI6Hlw9ID0zc9YNNsDILg4LE8c9EpBOiYlTZbPJyONeFj?=
 =?us-ascii?Q?Sa16zHtv+EoxM8OowjRqGlThq6GsF665ZpMe+IFrSYLMfKYHdzoWw5hjRq7o?=
 =?us-ascii?Q?HIlrmSl5IBNyAeIF296BagwUuxR5Zs6uytIDk0rvUVOWy3eKO3qd3XnENThh?=
 =?us-ascii?Q?9XoWpIRrJAoGm17OQ90eVNVkkqb/NJooA8sqcfmPezsRx446PZxFWoplbBNP?=
 =?us-ascii?Q?prdDqByssmdikroLQvTVoo5OUaxUtDf/j0HMk7K3zRgbwUvzhE4uBSGTRPM6?=
 =?us-ascii?Q?Yfg81iK/wBt0tVjN5GBbZiZf/0OXcBQFk2/FA83rOBsiTYt27bL9GwwBEUIk?=
 =?us-ascii?Q?5tTdZXIX8kroCYtPNPlSVpkU1ZW8L3hlm1LMQuBqrJLTY4lm/e9DD+P3Oq/U?=
 =?us-ascii?Q?xjvQlZ8IS5dIGp5R+qd/EcFtjENwrYIeUte+I1p88WXPATEi86QMUCkuXOaK?=
 =?us-ascii?Q?8q0qBrqDKBYFPadN33wc50i0xA4ASH17bD4nrEgh0iomlExeO3O3o5O7NslV?=
 =?us-ascii?Q?Gikp3qKfY5mWw9o0PVv7mwMvfRF5oIUE+aTnIAv4x1h4BJtUFQXpluQPisKR?=
 =?us-ascii?Q?dqhHhqbldNRO53B+56KU17m4yeASZH45PdBrumMQZ4jXmw9xJtq8MUpbHjZq?=
 =?us-ascii?Q?osMZlXOguUFrbNeRt3Wea+bp6xCHVhouhH5AlJWTz9gJivdPL65w2AexKXrN?=
 =?us-ascii?Q?rb/reGKqtbogRvPy6/NtUqZlczeogO+Wmwv9If55hAzyUtoOIvTN4JkqHyA7?=
 =?us-ascii?Q?/lpTA+0lDbaImF3nCbaPIgvuQyXybeeGsSVSLz4RwxBddP/E029TZd8EyHmQ?=
 =?us-ascii?Q?4BZ1zSpj+xpHaiO+9Q8zGWIRSQJ260v6sjeF9EAjcw/EdZmMc5MIzxCWWNNU?=
 =?us-ascii?Q?e4//wJPXxqUOYVnIguxjO8wq21obYICtmXgiSG4WbazPSagVSnjkOJm6VRfZ?=
 =?us-ascii?Q?/YrEHTh0ydi9n7F080SEgbhq/Y2azy/kMd9o1Tn6ms8iImNavkUeXc5j7Mrr?=
 =?us-ascii?Q?GYuAki76J5MIfGsafnNxbV7Rg8SrOl03YTjI2T7Y6mPlLX/UMZKZuxxUyAuQ?=
 =?us-ascii?Q?RnofizFhi47/aMr+mvoWUcSfz/rjaTfoH6nRhLt0fEo3JxKPx2fjx6ZLbFjJ?=
 =?us-ascii?Q?pa5TPcrWELahMNSbbIVcxvXsDr5ExP9FhFVpxg3JTCuxBlQksaa1MGkOgK7S?=
 =?us-ascii?Q?gt/trryqHqJfoCWhEh8h3FQu16QV1LvXIOJDzYoVsrO8v2k1ZwsQFv2bK99A?=
 =?us-ascii?Q?ekFIQc7VIMx6uBiTcw5eKPnt9+1gZjxfKyIVUMRlOyf2d6/XP1uTZbnGEBRp?=
 =?us-ascii?Q?c2Axv3AVD+n3UAyqp73vWJnDC2kM79hnAGzI57rOsJSayX2J0axt9+31Nv21?=
 =?us-ascii?Q?ZbOrdJYIGYclwomO1ivqWOA11B+wSTcI6zmmqC0T5MMKYv8QBMzu8HlpkGoJ?=
 =?us-ascii?Q?4ux7OvfmMj5F/1slK8aIr5p8i2IHPg/FtNX5rAGvZq2FrWyzBZvrvMiYE7JQ?=
 =?us-ascii?Q?jltXi+dGweAfY6ixwadY1VnSzFCeOe9ZNG/KsQdbip5t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(7053199007)(7142099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k6uTK0L6UrpHbovJA0h9YzF4zZWbHLcAWTMv3D9GKDuRTwFhWsKCVbsA1rTr?=
 =?us-ascii?Q?nmWOOT241kUMI1pgHJZhDMBdGeIAOpkSFcDb9EG7n5JbLLbSMYMadIN4y8bP?=
 =?us-ascii?Q?L0kXSzs2gC/pfUhoYpQJpmHdZL+uTJjbrj1UnBNhVFqnUsWZ269RCDQZd5XU?=
 =?us-ascii?Q?yBzA8j0YIE0OCkPxp3qWe94B2QcH0NqZY+P68NmRl9dcJKWJaUNPhlVI58wL?=
 =?us-ascii?Q?XSC6FI+VbBNCPFiWi6XRZ7nm9dcANwv+R2hhodJYUgBKwKRfkB9ZG1hkG/Tu?=
 =?us-ascii?Q?Uq3LoIBfxGiS16DHbXPmvYPIPuSPUjxv53E+VsvQPzNXeKrxJPfXrM4APFYP?=
 =?us-ascii?Q?kA8MREsvf8RK1tNP5ccn5r6rCCnIcwMM6FxG2ttGRaSumpvcoBtZERFvjg5B?=
 =?us-ascii?Q?/NL/9kkl7MGrqdelxC35lVjdNvAx2psB0YsYvnK6ImWSb5cwnfpfLlU0mbXz?=
 =?us-ascii?Q?zvWmA+be0X4b/3L6OibyZz3el8ShCJiKdpcXXYjr9/+8MoIofcN9W7UakFBO?=
 =?us-ascii?Q?vXZ4JwxqAvwmy4QXIBnazDMDafqX5piNjBZPmHU64/eqw5qEHBzeaf888nys?=
 =?us-ascii?Q?CZiBDP3bSxkb2dhg1B1oVmoztzy/a4HecdGCaIRXJdr14j5j6GPyZN0m6wXe?=
 =?us-ascii?Q?CvWXYVvQepFe+E3zNDdgnmW8kS6/TL3TmurWmucrT7b2wtg9A7ON8A1/HPxf?=
 =?us-ascii?Q?0d26vSB1+BglgmDZLeLxU1H9SkMxqX3J6r1SvVRFcCor1r8dTA/2ry+2GTrh?=
 =?us-ascii?Q?iw2DOxlg7Oz/RNPPmFh/d2UBwAiJT7L7ktVii3z8yllNFhghHAsZfBWhcgPr?=
 =?us-ascii?Q?s1ZIPBslaT6m45ZA5IJEsX3BJ9koRIzqgvT+Rqtg84jp0ITybSUbYsIWZ3zS?=
 =?us-ascii?Q?Va8SK/o1dhRgCCYaBJJ+iPv2xJaQ4yJaLVdgK0XVoUA9GNb6aVwUlY0uq5N2?=
 =?us-ascii?Q?hyISk6eQeD+YMhiCHOnnKN+8H2qJzOfeGpaHXZoKZtEeARsEFGGphwcXpjvm?=
 =?us-ascii?Q?kjCcM/cQSPFQ1Dxf3kPdEZLZhwG8sTceOYw/U3ZhqAMHlRD84K4YBzUGSORc?=
 =?us-ascii?Q?w61gZ23rY8jHZ3M9T7baczVZDOlQsRZxPGUrlE70N0Smnnd7E+KUdR4osmEH?=
 =?us-ascii?Q?yBGlMS7itj1TTzX87RfLP/Z0b4h+q1RTHgUnZoJ5hW0UgTsfhy9U8G5PRGZ6?=
 =?us-ascii?Q?3O4OStI4ISMnttjkZefnmG62l7S1SkhMtY/AoGPN3b+4fvrMzLhPiYXlKe8t?=
 =?us-ascii?Q?UBO/OspAoVGLjyOvGZi8SZxjASDanE071vfFURWEd88X1wac6vSvVK0L2pJU?=
 =?us-ascii?Q?Th1foj4a2C0d82efxR+WsMfwsAViX7OcS/Usi1rutBT+qOQYSTpEVPYcyElG?=
 =?us-ascii?Q?eQ2BWN7xIJWCIyo0+Wgo2KNnOU16XXAeCIfTaUvBufIc5gWRvUlmS0LieRrb?=
 =?us-ascii?Q?NARx+7gnS5dsjzdM+i31/wlSGKLk8Hedq1VnSXnjk+EOQAODyQ6HF3AmGC7/?=
 =?us-ascii?Q?ePRFsaJUbfMt9DVBGGpnXcy6L47BWaixzgzuOarCpqDU/bam0oQ4nNKlClq5?=
 =?us-ascii?Q?8TwqsM2PeoiJB7XGRK3EQTWLspnY+4MYd7fzdMp/UkdhdBqXTz7M5L3TOEt7?=
 =?us-ascii?Q?tSjYwieUBi0L0eMmsZNwo+iV2+zxcbLmZyALfaGdJydsWhJyNDc4CJz02WSi?=
 =?us-ascii?Q?3eJzozDfciX+MxV73fVMQpz22PCMExsKkShUvDsgO6I5XKZmomPI6cXZu74F?=
 =?us-ascii?Q?C7C/Wc0gzw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eb7307-8ed2-4d79-3719-08de73ed1263
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 21:38:38.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WdespFdb/NPprMcTcaPI6M0NlwlJozTvdBj/e1Eu3864iWud4iwGrAtUf1H09fztRj4DgzhnzHnlbBazIAyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6872
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8974-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.microsoft.com,vger.kernel.org,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F145018CCF6
X-Rspamd-Action: no action



> -----Original Message-----
> From: Tariq Toukan <ttoukan.linux@gmail.com>
> Sent: Tuesday, February 24, 2026 5:22 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; Andrew Lunn
> <andrew@lunn.ch>; Jakub Kicinski <kuba@kernel.org>; Donald Hunter
> <donald.hunter@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; Kory Maincent (Dent Project)
> <kory.maincent@bootlin.com>; Gal Pressman <gal@nvidia.com>; Oleksij Rempe=
l
> <o.rempel@pengutronix.de>; Vadim Fedorenko <vadim.fedorenko@linux.dev>;
> linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
> COALESCE_RX_CQE_FRAMES/NSECS parameters
>=20
> [You don't often get email from ttoukan.linux@gmail.com. Learn why this i=
s
> important at https://aka.ms/LearnAboutSenderIdentification ]

> >
> > +Rx CQE coalescing allows multiple received packets to be coalesced int=
o
> a single
> > +Completion Queue Entry (CQE). ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES``
> describes the
> > +maximum number of frames that can be coalesced into a CQE.
> > +``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds
> after the
> > +first packet arrival in a coalesced CQE to be sent.
> > +
>=20
> I am trying to understand how generic this feature/API is.
> Can you please elaborate on the feature you want to configure here?
It's the similar feature as MLX's "RX CQE compression", which merges=20
"multiple near-identical completions that share/match several fields."=20
I'm adding this kAPI for any drivers that support this feature.

You may find driver details in my previous submission:
 [V2,net-next,1/2] net: mana: Add support for coalesced RX packets on CQE
 https://patchwork.kernel.org/project/netdevbpf/patch/1767732407-12389-2-gi=
t-send-email-haiyangz@linux.microsoft.com/

> A single CQE to describe several packets?
Yes, up to 4 for our MANA driver.

> What is the price?=20
The price is the latency can increase a bit.

> What per-packet information/hw offloads do you lose
> in the process?
For example, the vlan_id is shared among up to 4 pkts.
But, the pkt len & hash are per-pkt.

struct mana_rxcomp_perpkt_info {
        u32 pkt_len     : 16;
        u32 reserved1   : 16;
        u32 reserved2;
        u32 pkt_hash;
}; /* HW DATA */

/* Receive completion OOB */
struct mana_rxcomp_oob {
        struct mana_cqe_header cqe_hdr;

        u32 rx_vlan_id                  : 12;
        u32 rx_vlantag_present          : 1;
        u32 rx_outer_iphdr_csum_succeed : 1;
        u32 rx_outer_iphdr_csum_fail    : 1;
        u32 reserved1                   : 1;
        u32 rx_hashtype                 : 9;
        u32 rx_iphdr_csum_succeed       : 1;
        u32 rx_iphdr_csum_fail          : 1;
        u32 rx_tcp_csum_succeed         : 1;
        u32 rx_tcp_csum_fail            : 1;
        u32 rx_udp_csum_succeed         : 1;
        u32 rx_udp_csum_fail            : 1;
        u32 reserved2                   : 1;

        struct mana_rxcomp_perpkt_info ppi[MANA_RXCOMP_OOB_NUM_PPI];  // MA=
NA_RXCOMP_OOB_NUM_PPI=3D4

        u32 rx_wqe_offset;
}; /* HW DATA */


> For comparison, in mlx5 we have RX CQE compression, which can be applied
> on multiple near-identical completions that share/match several fields.
> Still, there is a per-packet mini-cqe with distinctive per-packet fields
> like csum.

As said above, we have similar "per-packet mini-cqe":
struct mana_rxcomp_perpkt_info, which has pkt len & hash.

Thanks,
- Haiyang


