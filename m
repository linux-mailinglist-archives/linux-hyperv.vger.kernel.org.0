Return-Path: <linux-hyperv+bounces-8153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE934CF4E1B
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 18:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BAFC3003517
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6E8299947;
	Mon,  5 Jan 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VFkZDf5y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020074.outbound.protection.outlook.com [52.101.61.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CF27E076;
	Mon,  5 Jan 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632570; cv=fail; b=HT125j0FHsNa5kAoJzqClnmyBc4XOHrkH7YG+FK1IZtPfuXotW8tISoFNT/5ySEK031AoLdeUUNkHxaAtkuvIaayKPXecATJmViBUwiECSvDL1amOucok9UUXkKDzA76WXGqwdE9l/RR655z+l3hdSZYvoRWE69YPNbKYQwe88w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632570; c=relaxed/simple;
	bh=ibAkGp3XUsIA6pt6fz6QiuySw8ZGpJO3Wk9iVD8Pdv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2BubUZ2BVgk6m3kt74XkM+kZsaP5sqX8xCgK/m/Nw4dEfU9wDH55+Vb27hswp3e01MFfr1mheRdqrCItg7kDLmJJlfrN8v3nxTJCahAIs3q28FnBPTiD00KFmd9uuTOKWxV+9EVKlbZpo9GpVowkSRALRu1Ehga9hTmMhDF1rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VFkZDf5y; arc=fail smtp.client-ip=52.101.61.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocNAecATSJ2O7I90a8LVE4GccdFE33CQDve4xroXly/5OFezZrDJbmk2x/iJzP5u9tbcpnSCRszXiGqmD+R8pXE79Fyg3oiZJjmXIlPT6pini9RF8N4YqueWDsGDOuPIGzL7Y8Oe5BaM2FhXP+WAmSkAcJhhoUO1bx3xiZ7cPSd9PhvGdhsprHRtgmJozDHgSy60urbioPBTh6oQ8FZEEO2ErTzyNiISsfUJye7X4qvUx7mAuuBPd6OpTivonitDdlY+iBmDHxHI5SuMNqjt+vuev3DoqnfacYmzd4H/PUzO4jb5c20JUWBlCTHTgXf9FzIbZO+NY1bOfOzkOGxjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkTQ0VBhfY1Bev6WkMq53jRCIlRNO6fpYzqMXoNiMvY=;
 b=fvmK5ajnQN3zgK9GUsJPhOgo45Voin3NzwWrWG6tApDgsnPC4rvr9pJWUOxytt8Zlwo4w0oQSQmKI74F1yg1AG0yJkhjk2LLSY8wLeACApF4Mb2s2XZ3f7EyOrkpdDVeoiLJDmCQhHSl1Wdu/P3/10033bipgzjczx2Pr85N/yz6Woxy1M9ZC32V9Z7kkci7w1P7FOJOCfpHXs6Fh2gWkm8sT3uAjVfYVCgpNsJf2MZ/rCi7ZtEOGSGxLPDUEEh5Vq9GfSpbR5aZpnq/HzElletqyzAn3rmDmz+nXXyH3FvKEIBXFOrcqTZbhKmQVkubwY2wxuGm0xEYhNmgewytQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkTQ0VBhfY1Bev6WkMq53jRCIlRNO6fpYzqMXoNiMvY=;
 b=VFkZDf5yoBrO8qCAoAcnc75SQDFWRAnW2yPm1c89IC2aip26aY6/5H48qMZA7ok7QeqgOdf/NFobKKMZ9LlJnW84Moc3Qd5X6A6Tq+NA32SVQkpcuVP45wZ04ONc5MYIZkDpamnmuRmzp2dFFqCabaKYNPZG0GET0M14SvJMeeE=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6778.namprd21.prod.outlook.com (2603:10b6:806:4a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 17:02:43 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9520.000; Mon, 5 Jan 2026
 17:02:43 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH RFC 1/2] net: mana: Add support for
 coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH RFC 1/2] net: mana: Add support for
 coalesced RX packets on CQE
Thread-Index: AQHcbqTQSuopfBsQU0Kdu1gm5JI9E7VDlWiAgABXZNA=
Date: Mon, 5 Jan 2026 17:02:43 +0000
Message-ID:
 <SA3PR21MB386756824E5257A24338D2BFCA86A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1765900682-22114-1-git-send-email-haiyangz@linux.microsoft.com>
 <20260105114929.GA330625@horms.kernel.org>
In-Reply-To: <20260105114929.GA330625@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70bf5ec4-8b20-4823-a5d8-ef3518654f4f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-05T17:02:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6778:EE_
x-ms-office365-filtering-correlation-id: 47ccb854-3a53-4efc-48db-08de4c7c3df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uyPtnyvtmEGcI53n20QFtQTVM3DPtWaiYncz32eLjAydb21D+9KssyTtGaCt?=
 =?us-ascii?Q?X9dngfgMx5PBFqmNHqXoQ/3wmYFOx9KPjDqxXwtlTr2CBze/aIyh5F5ZZn1i?=
 =?us-ascii?Q?YW5IYKIkoPrdrqgFZpkRvOq78pEy2ZNNJNKIIcI35ShhY5HENGcFVaC6CSw1?=
 =?us-ascii?Q?/xJ+rhBTdwlmDcNtwy072CD3CkFQXJXgGyvGG3wMsAAaic8psrzYBIUgXIVu?=
 =?us-ascii?Q?MJjEuWwSCFUWDFw2t38+j5QUy9r+MUpe60qxIYsmJu/XV2kioukGOswYUrra?=
 =?us-ascii?Q?oDkraqY20LHQaRlQ/9jT2iKQxqJjwHZUaZ9hjkMYraKDGB3fwwVAs7CDtbLo?=
 =?us-ascii?Q?zYT8wX4zUNNSiGOQLcNqe6wEy5PxHL1pfUxcbA6WIqlxPgwuFRUA2LSxz5KJ?=
 =?us-ascii?Q?JeHIEtQ62ua5wUnF0rDCnmTXjckcQyUKg3B9gDg9acKwtWFKx39T/vfsCm4g?=
 =?us-ascii?Q?JwHvz0vGar+7GSW2AFlomqMyEdq0JM60CqueGPxHX5MoklkDsEgM5lAO/T8D?=
 =?us-ascii?Q?5dIlsubamCWKg183tC/+TlWGooiBokzR/6lPtLcymk57rxmcqELfQvfqopFJ?=
 =?us-ascii?Q?ZAVqNl3jwQkPjGe4fR8zV0cCoR/jEzySUi4swXGtzx9NR/ZB3jH5PcXZubgV?=
 =?us-ascii?Q?MrT3/15tbQlmpWmJy/hYeVSt3qSgwDK4KA/DEFsg/cNt2ItVzwYM82JTIcA6?=
 =?us-ascii?Q?4gcVJ2cF+EmI6pYlhouDzuQrpl/qEYjFnSoWzzRvDOa5fO7nKF4awxpcE4vj?=
 =?us-ascii?Q?+G1b4dhntemjTVA3e7Umk9DIFewQBfC387DMJlh9IqukJSC3M8Cn1oJzsnpK?=
 =?us-ascii?Q?eKBQvAcyXVB7cGfm3KEf+zar4AXIxtDpctK+yH44dyi37D8yWnIX1zamVNSs?=
 =?us-ascii?Q?REPuNOlJGIPB4yEu8xEqqyUuKTflIi7oUolOK/rkMbxO9f51XZJUZIypZwGL?=
 =?us-ascii?Q?tMkCymd6bX6tZskShr3Q6X4ECOhQxBEGvr17oJIk14LjfSGgwrsC82W3ydkL?=
 =?us-ascii?Q?cQ72iRGiD/oUay1vsbPSiZrmOeokxXH5eTpXKwUDBtxGDM3IoTUlPGaQbAtj?=
 =?us-ascii?Q?D+M0wTwpz1zGux0msclQ28W0VJ1VXizx/vf9lXoZkS7gfABsseKF6c4Q1Y4M?=
 =?us-ascii?Q?i3XL88pvUGuhvgJnD5hM/AD8e6/C6EaWqGUg3k+E6ChZ+JLhjH7s6wgjpZn+?=
 =?us-ascii?Q?YJfwPyzVoVXg0yVJ+8SiMwL65ZJXdPNI5EcXz9u7KqSOd6POzZ/oRytSZnWi?=
 =?us-ascii?Q?ceE9RymSO7h64OBPgt5vvqrt55SjkX5s4i9tDoM8xA84/gkeAIGF6Mpsr5eB?=
 =?us-ascii?Q?LtTwVNiAajKHdBxYTPWgFSgpgm/DIz6+/Ov1gMedYw4USaWMNjjrK1wfXWpE?=
 =?us-ascii?Q?ds99P77Dl/TP0OBW7AMmzweCaibevJEK8WL7KAP1b1c1z5Dlam7yz4cKJ5B/?=
 =?us-ascii?Q?vTuHZ/6P9BHu+fdLSES43grkncidxz04xHsmDHeR97OKFK1yjSWOtXebFBIE?=
 =?us-ascii?Q?HwYOkeZpsv54ucnN/NT0eO4+eOe4uf5HCTQx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WJh7yNrv4te9rh5QbDsufQNxqFCeV+iC/mgbJ44uLxlUFhOU3wSwMbqe5oE0?=
 =?us-ascii?Q?AZDTmlzK8SAYSCuh1F+0kxkOIBm6CXjrgL2x3b5LIwCWrENMrVlYTtR7M8S4?=
 =?us-ascii?Q?BpsFoxZQBdT+v0JXZyenmom0cp3F5P2v3k5kRicxv94BwktjUL3be7iTrY6t?=
 =?us-ascii?Q?7Iey4KFH6pQnNrHIsCM+jxGOH62nipedZCLzxwT32N6fK6yEPt/+rebwZIZW?=
 =?us-ascii?Q?WavIhaXTxAgTIRU5avrbECkDs/5xGll7R7+nv1DrHk8IXjNaGsg8A8A8cAT+?=
 =?us-ascii?Q?OCd9zu1m7u0u+TOMt+CutfqefTmTK810NvO7fpNQ4MarvgGOo+tlZurg3A6+?=
 =?us-ascii?Q?39v/zp3Myt7gCe5ZaoHgzgmkv3UAg3PadfliMzplS+f3bAjhZVZejwgRmjV4?=
 =?us-ascii?Q?14wu7brM9TnJaKuTDqnkkjsWln+YNTOAtpQnIATRpRRKDQhhp0LvgPTNwJST?=
 =?us-ascii?Q?8jlZzaHFzMh02n5ow6Bse/qjCAgsFL2TyvSIeOG2MLW1yXKAmUBN9d4+8IOZ?=
 =?us-ascii?Q?2Ccm/Ed7CS8zMG5rcuFzaILt+fpOmLOUQPxbuJ08nVDtrlAlygzuX6QWtttJ?=
 =?us-ascii?Q?wcqMQ+VJu5RR/qBCLB7oi3GPKnz7wDZ6lt9E5JBVb364x/DtaNJaqRViUEKY?=
 =?us-ascii?Q?zisDAOykiEJFZ59WlVXww1qBKRch9JAlLRuZczEEK1Ty2a6Hho7yOI/Tv8iy?=
 =?us-ascii?Q?mR0oVV1C6EdjKDQKF+aC6IlOUDGPm7KNX2yj7EOas7lbiygSh6DzylVXJ89o?=
 =?us-ascii?Q?JBlW2L4KkDkGPEtxLrrxK5AcDJMO/cRviPJ8NJO0GukPDprtUa/PfshxN8Be?=
 =?us-ascii?Q?Cm+WbgJkmY31X3zKP4o4v7+vO6QYWvg8831Tkzlxwd45OPRBFhNNnybc/csb?=
 =?us-ascii?Q?1h2RabGi2iXPZsQaoJhO+m+sfGxRn5DtwznWB2K1QIKeZ+gujtruF6PvFEVU?=
 =?us-ascii?Q?q79kmpBCC7LJvqST+MXCeiJHplSaYsr1SSyMvtXZBDAOjldhPFvOYInoxvHS?=
 =?us-ascii?Q?DkLzx6QFjtwdol5xTGuGtozqsg9KcVVfSIjLEad/MBVsxrQ17+jaXaT6hpi4?=
 =?us-ascii?Q?aXYkTEKsBF7acgjvDFq+gaisYxa4RLnL6yRu1SC29XjhMCxJuh6toTEq1nyO?=
 =?us-ascii?Q?OYPoPYySsm1Mm1G45VG3LxyTmkMqeQNUQuMUF1UnMqMAt8GKbr9H3qqgq8hj?=
 =?us-ascii?Q?cigsDY2nRD6KoLihmUWr6sstJsXw4+yO7Q6CV7RuGK2R7KI5sTpWRnvR5LIi?=
 =?us-ascii?Q?Wmvob2nBlRCFuSf+1XANoXz+FxU2EI/X4ahCUP0QmPU7SGpe9jdGZSToQcnE?=
 =?us-ascii?Q?fp6ta2ZTByqUzGYupjhnUoHDpx4KWKWLo0iTbBoq4La8ndVci1BzDJ1mGhLb?=
 =?us-ascii?Q?gQVcmgpsOuv3KalyGxcS6+ckFm2t5eMdQ1KrEy/NuFN3xR6jnCzOR2yz9w3Z?=
 =?us-ascii?Q?V+D8x7L9IObnVRCGwxNnOvW3BOIRlRkOZEO7odAeiFfal2TYzzMl7u/eD6v0?=
 =?us-ascii?Q?eOnYhdtzkmnBA0zbiEWGiaJ4rSjaOsXZj737HKmNniy6XC1Rvhw34l2c0djg?=
 =?us-ascii?Q?vBqCqv0A1LIAIrGZD5CFGbTRmZQWJiWCUG3Uyi6/Sh4feCUpw0Azv+UDyxcJ?=
 =?us-ascii?Q?SUfwZAWyc6YDacb9k8XwNArUMa0Ty1J/v2YDAVJce16zuJThOR9eznATcYR0?=
 =?us-ascii?Q?ebBfH+alI12Phr+Ecu1fLColeOAR2vPTI7wWiT8bEOYQBXaAOMACa3PHNLyF?=
 =?us-ascii?Q?bJgzbcpeCQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccb854-3a53-4efc-48db-08de4c7c3df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 17:02:43.1847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClviRHaBXMoTcNOBDqkegJhDgy0slaIIgJYqUqg0V1GW8pd1xRmmukzdmObXsh6KNyMVg/hoqBr6Ej+iCylEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6778



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, January 5, 2026 6:49 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Long Li <longli@microsoft.com>; Konstantin
> Taranov <kotaranov@microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH RFC 1/2] net: mana: Add support for
> coalesced RX packets on CQE
>=20
> On Tue, Dec 16, 2025 at 07:57:54AM -0800, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
> > check and process the type CQE_RX_COALESCED_4. The default setting is
> > disabled, to avoid possible regression on latency.
> >
> > And add ethtool handler to switch this feature. To turn it on, run:
> >   ethtool -C <nic> rx-frames 4
> > To turn it off:
> >   ethtool -C <nic> rx-frames 1
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index 0e2f4343ac67..1b9ed5c9bbff 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > @@ -397,6 +397,58 @@ static void mana_get_channels(struct net_device
> *ndev,
> >  	channel->combined_count =3D apc->num_queues;
> >  }
> >
> > +static int mana_get_coalesce(struct net_device *ndev,
> > +			     struct ethtool_coalesce *ec,
> > +			     struct kernel_ethtool_coalesce *kernel_coal,
> > +			     struct netlink_ext_ack *extack)
>=20
> ...
>=20
> > +	if (err) {
> > +		netdev_err(ndev, "Set rx-frames to %u failed:%d\n",
> > +			   ec->rx_max_coalesced_frames, err);
> > +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed:%d\n",
> > +				   ec->rx_max_coalesced_frames, err);
>=20
> nit: I don't think the trailing '\n' is necessary here.
>=20
Will update it.

Thanks,
- Haiyang

