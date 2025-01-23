Return-Path: <linux-hyperv+bounces-3755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D0A19DF7
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AED6167FDD
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335761ADC6E;
	Thu, 23 Jan 2025 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ITY/nu5X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020143.outbound.protection.outlook.com [52.101.61.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7B629;
	Thu, 23 Jan 2025 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609908; cv=fail; b=a54pbCZv2AJzarMTFpdSeTPoYaQX/yK5aUAmPLZ03UWx7/5cOtV0h9T9hJeACK3yEyeGFXgdT5BofvvFmz+QCrEnMT4JsADw/QdItqIZgu7sDzkdASSzp/UAdQZeK48uAUNgnIme77X0em/OO2ybHu8ZPi2pfoxbAssdR+3pf7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609908; c=relaxed/simple;
	bh=HSAcfhkeNZ+1b9LTn3rXU2GkDQh39L+gPrBS6UtaXYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HE0P86OvQtFy19Ug2RR0gVLp8ySbf8rESCXEJRi74IHWX1dp4otY0WlGXhChiTg/zfln3Z4Fi7Hu4YmbXSv1uC6drpHXXBtPLT4+EWuU0CG+dX35FaS856ivaa6xwpB1W38hzIAcJI7tnWVbn465piCXYcfZn5WEcl6HsMiV84A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ITY/nu5X; arc=fail smtp.client-ip=52.101.61.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8Me9xssQdZm8rXStj/ydypj5PrpuCqSuTHveSho88awhsWhPruE+xh/p20Zu2TJdzkyIjb+ZPdLQUxtbpYmLrDgSOFajjzt0eNIfSk7lYKZUNWctZgSpo+fvnD9j9xRVFNRpI7vP8C4voiTRkiVf8E4JmggDjMUzn7PYFDiXJ7C7GdH1eaQSWAtpbyn81cdZEIDZwmZ4SRaQOgqO47AVaHjtqeB1R3wfFBALWCyFBSjpmBxhjBzDjnPnw+UrN5biVG+ClotU4CmuKkd9HRmi1Rw5qWl9Rh1tlI+9gshfW3/7oU+MSpnfaExV2Bjne9vLGPSQ3i+31a3hbWAjHJvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0ax8CFHNkcx+oZZZO8RIBzjsjV6M2kLV3Ed827KpKk=;
 b=FQJ6qdeZZZerBWyoh6ZiTVYcF3Jms3BV92ue15s6q7f8ql0QeYqBNlVHjwaZDDVOyduaMtMBFuoHViVzUmZjkubyjhL80OR4W5K79QmRcOkhsxA+/cdviBK+C2Pak+g1dHkhhwTRu/WHtTlGOQfhOCIChpxpDo4of3pI3HRZ5ohCh9MJM74+EFsKyiuW9bz4StwRjjrXAkCl71p0WS/6ZSPdRBmbcaLaLdwBEb53mYwqBhYmQ21iztfbCSWj9MJQFy5I71iNOuA214id196Q1VSrgGz+U7EBWZWEd0i/Qadf+1YLfD82SwSaWKM49DaOMjzl51Jf88sf5/oSGH968Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0ax8CFHNkcx+oZZZO8RIBzjsjV6M2kLV3Ed827KpKk=;
 b=ITY/nu5XpxJKnZGcTe+Yaohd6Nf1T1Qsl5icAsYZbLAgYAF2WEMOYG2s3wQk/Z7xiTrcGSUxIoEYf78xEvMb7tWR0GO7ELl6VNfoAuC+NeKnRpP3h5nC+Rh+YZ828KO5ArHBJjjeSps9ojxTSs2zBOHtTHz2vhTRzSCqiGZ6tvw=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4302.namprd21.prod.outlook.com (2603:10b6:806:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 05:25:03 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:25:02 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 03/13] RDMA/mana_ib: helpers to allocate kernel
 queues
Thread-Topic: [PATCH rdma-next 03/13] RDMA/mana_ib: helpers to allocate kernel
 queues
Thread-Index: AQHba2CWcM35Km4xg0exUco8hEVA4LMj14Cw
Date: Thu, 23 Jan 2025 05:25:02 +0000
Message-ID:
 <SA6PR21MB4231EF74ABA149C87531E749CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=120715c2-3826-4eab-9b2a-e10536629659;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:24:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4302:EE_
x-ms-office365-filtering-correlation-id: d8a45404-7208-4cb8-f7ae-08dd3b6e496c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b5FseOt1JbOX8Q3wqe8U7LfhQHlFjKipzs2TurXY9ncqsqLo302BCQ0fHOs8?=
 =?us-ascii?Q?kEJGTt+p1PKPAVDLtPNxdA9k7ih0wkPOfhwbpDTlPW4BXzLl32RdKROt3Chc?=
 =?us-ascii?Q?JFvZc1/as6rUB+a3WrAOSYMyqujNyzuH2ru3/n6yHLQbkYu5P/jMHFOp6YlH?=
 =?us-ascii?Q?x/cZ2WwlOGAKLyobLZshjjGmSOIVkLLyoZXJit7YVqaD2A38S7HRSG2pVlVM?=
 =?us-ascii?Q?ksX+mLCYwiNulmWZbpCddfGMEOGV5utbPRsiEpBQ0128kJ5g2bd2CXG1xf+N?=
 =?us-ascii?Q?J6s75Wa8Vg7/cNeJFKptKWOtoLZvUa8n5RZuasS9PQbn8Cz7ZbbS+JuirOzp?=
 =?us-ascii?Q?0F8qZv1e1PkcCfvJmNLcLvFtBNxtlYTnl6F6BCbUMekCsdsQSwbY9Swips77?=
 =?us-ascii?Q?HEDKx1FL770qNuWk2qEf0aN2ukKcZ4Q4ssZeOv4QNC4gDc5qNLhQeeZswBgD?=
 =?us-ascii?Q?hvZgclQ5fnbihA7nfPqTmKLv1lIDH/n795PHQtlvq0FP2FYpn4I/dZU0hWF+?=
 =?us-ascii?Q?usEPsTEICeqnnYGNfhK+rMIOTW3/x4DokiGViQNx9jnHuibpc7sokZGctYD6?=
 =?us-ascii?Q?nxyBS2KFbZruVo+JkaHmyMZBf6mmv7dsU+WOw9bvOmCn4RCzn2qO8Pun0K5R?=
 =?us-ascii?Q?ZCse2SgqEHpHSFNqh9Hxnvf06SDVXA0WQfa+rVTcJDVr8n68jyuZSu+GVFOg?=
 =?us-ascii?Q?WyLztI7oRj0n7Ix4Z86igHTQIGchA+2uJ4LJlqtkauMawWLkZbvSK++bNdXX?=
 =?us-ascii?Q?LON/qMBZ1tp9MUaXLcAOc1lgJv+Jy0PPZGyk5Rg6FPd7bYA64O8Xv/bZ+FGX?=
 =?us-ascii?Q?blsCc4z6fhDLrWZ/s/ITfUTmfIrX2ZcBOkeGi7O2Zkk59q5E+8Fh8IYNP7L4?=
 =?us-ascii?Q?CJjv5OJjf6/J+ZkVQxP3sXs29uxkIfY7VJqECosWRyIWop58S5tf6PsWQC96?=
 =?us-ascii?Q?OlzrC8LkQ0/MRFIYp1xOL2+u1Deh9Krg8+qWEwW5GwjIGvvw+Y9vZDiQQUxv?=
 =?us-ascii?Q?t7+jJbXV8o3H+lq9aIhlbMvlmNjIy6JkAcOvQMoipjAsRSrocQ1p+EjE5zM1?=
 =?us-ascii?Q?iCG/xFbWNzxNmdHlIlYh1Uh9i7q6yALeIn6NgYb9essRrXPnUjtsedE9AlLP?=
 =?us-ascii?Q?pZ8EjVTKFWAfp436gc3iol+5jyKzzbVekO/pnJpm5E7xVJyGdZ6amn8KqFsY?=
 =?us-ascii?Q?ZdBjn84CqC0teAQBxA1OmOZL3bQaKFtlMQKFAxToJ3xYSJp0lQCMt0Z5fJaH?=
 =?us-ascii?Q?EZDaF95wlXxLCaXKXDptLVWSOFlklESX3Z90vz6R5dcCPG+3Jq9Ca+tLf/3u?=
 =?us-ascii?Q?zVhdQ879Z6p2eeyj48fEffKF+YDJVG7xrJII0gWhp29rARxVkSiCvHpOcVE0?=
 =?us-ascii?Q?FaYn3KmgCAyG6uSLy2IabSzfZhusCjc0kMnMfJBQ2JrlcHfQQZcWPoVyvUJD?=
 =?us-ascii?Q?ruG1bguWdQy3KowmzEVXhEsK13Retk7657EENtds3m6zr3Inm0wM4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4uFkUdb7TP31UskkWLDALlkYjxvMkvKNVp7h6LkeO5YSL+R5/4iMPNQYkmGs?=
 =?us-ascii?Q?N+LojjuufrU8mC5l3hTgKyYbASl4uzNZaE0rKpI/wx2H3j85p4EmD8x2PDV3?=
 =?us-ascii?Q?0eNS8m5pQzLYcvoxQWDfIDvSSBJAZ71gG14lNjFX1I/5IH3/g3cYT4YPHZLr?=
 =?us-ascii?Q?bOaZ7mniZIK/JToJDGiprPHrN2tPXNZCtyq8jl/HvCcwst4tW89qEJ1kkxdq?=
 =?us-ascii?Q?V3XYmibPkUCtk/vxpaFy60GelwkUmptYshVtDGrV3urtA0oRdi3UC1dvXNPf?=
 =?us-ascii?Q?qeXDI+ptGlzbY1gV+s+g54yF4HkUSyN0fnDpshmAe9maJlVbTHizlA8Xe81e?=
 =?us-ascii?Q?uDwVH7p2zxHkji02UK73Tvpyvj84V2iV4S+bOqrdZg1Tk5j0T+2xeL7r7KeF?=
 =?us-ascii?Q?OFxGOeKsrZp4gVQnB1ceUvXYvtxxos8qm5E7frbDhH0Dx/PdQN7jbCNnkAZf?=
 =?us-ascii?Q?cmnenRXJDOU00P9FIILmDdEcfgZKabe3yT/DniMsjJaCjaNtmoG8f97IRlJM?=
 =?us-ascii?Q?d4d6QxSwu3HmxLSXuOKZkmAL5bmVP4qYZXP02APsJnpuN+zQ/X6xA+6QWelA?=
 =?us-ascii?Q?WKwNe13meSlQbLIsOix1RiVdDF1kQFeFdCdeQ+G3IHAdMnQJcPXBD9ASri4O?=
 =?us-ascii?Q?sSxbPmfTIukkb2F/bKl9anzTBYZQaxAsl0faxVKm3mpVaV07DA3R5aKgzU9A?=
 =?us-ascii?Q?KyMkXVfdmY7GHUTLJQjvlQggHO1RB2IJjJpBKQyGN3vbkq6VYlOP0QAAcr2w?=
 =?us-ascii?Q?W0EQmkfYPvLNgtRmAf2PhYfESvhjLM0oA4a3KWyzIz/bhnnij9kgXiw5VhO4?=
 =?us-ascii?Q?sexgGJyanwRFPXAIh9FPYmK9dVqU1+snBPvpas2ezeySIpaUdk9dqvIQ/Bd4?=
 =?us-ascii?Q?aov+VypQ5PhWdq6WPQKplStx3F7wzPM515phSkVTdHTzs5pBLNJpw8CdI4Jb?=
 =?us-ascii?Q?K++91aX+LXVvnIuwqZ3lUlZWFe7RhlobrRvHxR6jYdQxyiYBcaLV71s6IW0n?=
 =?us-ascii?Q?5Ad2+wbNHECRHCvLWPTrAnkPmGHFMspllmgDVe5Ed7mvIpAyPzMBEURr7acI?=
 =?us-ascii?Q?iuswSZJUBCRsaWVLywxlWxs6xSemmtZb6R7OkhVIPLi5UHW4g7dLVJ22IAhf?=
 =?us-ascii?Q?gz9KjfwDjTOCKT8rejH8bT2H8R1P5OvEhCXHByGgr2mRMIUkScIlLWC7O3nd?=
 =?us-ascii?Q?cxC7G6xRe1z18V2FLyA4rG4FIQ1G7oeF6QZYk1rzqJKIncgnBz4ai4IIaG76?=
 =?us-ascii?Q?tuFT0UPHfUz4rLOgftiz7eZcjugTP1fpCSCiX8F79SgIPPOU7wvII83VZbDM?=
 =?us-ascii?Q?R4Q4J3OBc4S0Ra+DYW5nXUZXgajROBRBrGGQLbMK3k/Fvll4mTXL94LKILLb?=
 =?us-ascii?Q?iRntXh8Dm8litXPqUpR5ostoikpBIg40GsEST3slzIcmJDwz2s1DuUF7rrd0?=
 =?us-ascii?Q?HxRFPo1ksmYxc21FRg61GdAj9Ize6UGC7BzNK10C6ZUlS0byFJY6yXgYeSud?=
 =?us-ascii?Q?b1dh9DkGkDyksiVal/QXe7Lwg+S5Rxz9J2zmCrBWyz4Rf51rZRyLAWDNYDmR?=
 =?us-ascii?Q?L3lGqsYyI/WHoe07TF8orfJBqC2sV9E3cszGQh+5?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a45404-7208-4cb8-f7ae-08dd3b6e496c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:25:02.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OUbZdJbd95K/5HgqasCQ+778UxKlzQJijQLCSwSJdt4jYsKxiOybue8Vwfeg+lxmRFu/NTsHwdGI13B1YHqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4302

> Subject: [PATCH rdma-next 03/13] RDMA/mana_ib: helpers to allocate kernel
> queues
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Introduce helpers to allocate queues for kernel-level use.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c             | 23 +++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h          |  3 +++
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
>  3 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 45b251b..f2f6bb3 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -240,6 +240,27 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
>  		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);  }
>=20
> +int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum
> gdma_queue_type type,
> +				struct mana_ib_queue *queue)
> +{
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct gdma_queue_spec spec =3D {};
> +	int err;
> +
> +	queue->id =3D INVALID_QUEUE_ID;
> +	queue->gdma_region =3D GDMA_INVALID_DMA_REGION;
> +	spec.type =3D type;
> +	spec.monitor_avl_buf =3D false;
> +	spec.queue_size =3D size;
> +	err =3D mana_gd_create_mana_wq_cq(&gc->mana_ib, &spec, &queue-
> >kmem);
> +	if (err)
> +		return err;
> +	/* take ownership into mana_ib from mana */
> +	queue->gdma_region =3D queue->kmem->mem_info.dma_region_handle;
> +	queue->kmem->mem_info.dma_region_handle =3D
> GDMA_INVALID_DMA_REGION;
> +	return 0;
> +}
> +
>  int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
>  			 struct mana_ib_queue *queue)
>  {
> @@ -279,6 +300,8 @@ void mana_ib_destroy_queue(struct mana_ib_dev
> *mdev, struct mana_ib_queue *queue
>  	 */
>  	mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);
>  	ib_umem_release(queue->umem);
> +	if (queue->kmem)
> +		mana_gd_destroy_queue(mdev_to_gc(mdev), queue->kmem);
>  }
>=20
>  static int
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index b53a5b4..79ebd95 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -52,6 +52,7 @@ struct mana_ib_adapter_caps {
>=20
>  struct mana_ib_queue {
>  	struct ib_umem *umem;
> +	struct gdma_queue *kmem;
>  	u64 gdma_region;
>  	u64 id;
>  };
> @@ -388,6 +389,8 @@ int mana_ib_create_dma_region(struct mana_ib_dev
> *dev, struct ib_umem *umem,  int mana_ib_gd_destroy_dma_region(struct
> mana_ib_dev *dev,
>  				  mana_handle_t gdma_region);
>=20
> +int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum
> gdma_queue_type type,
> +				struct mana_ib_queue *queue);
>  int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
>  			 struct mana_ib_queue *queue);
>  void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct
> mana_ib_queue *queue); diff --git
> a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index e97af7a..3cb0543 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -867,6 +867,7 @@ free_q:
>  	kfree(queue);
>  	return err;
>  }
> +EXPORT_SYMBOL_NS(mana_gd_create_mana_wq_cq, NET_MANA);
>=20
>  void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue
> *queue)  {
> --
> 2.43.0


