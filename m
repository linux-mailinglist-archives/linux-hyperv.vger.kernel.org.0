Return-Path: <linux-hyperv+bounces-4971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89621A92F13
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 03:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA3D3BB36E
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410D29D0E;
	Fri, 18 Apr 2025 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dx+aYuOz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020091.outbound.protection.outlook.com [40.93.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEB208A7;
	Fri, 18 Apr 2025 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938796; cv=fail; b=CLv/CVu/bCCRJS3em+WngJgrip09C/HI3o3qhVB8sb5H0AYAq+kEbPzO7ldOd+odDZHWpSjNCXeqp4ufAKbVFMsJNrICwbmAQcWUPFsMCPLO3xKoCCEMYMvqTffBEg65lmtYRpA8I1G4LISj7pfx5kd0CMy28rh+j1Ek+53UlKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938796; c=relaxed/simple;
	bh=qcBC4PAEBRqQBEqRcgCx9LoehRIDDFuHbDmTJ//+yQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7rcjyumPKGlUGD7mxmpsYv/lFtbPeTgW/XzF0YEny9IkFNz/duieCZTjlGXANhGFJutPS7DNDdkwFZep7fC5gjvIKxhwGS7531whGtJYGY0WL6rpGczXCC9O/5OnfscTjwMph9UnbNhubp5L/jIdE5/pNgsI2aIgBDsZTVh7ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Dx+aYuOz; arc=fail smtp.client-ip=40.93.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSq1fvgx2+WyW6uQgc965ZXYsVl8wzxiNVziziSJ91ECsarQgjv8OBHqlSZEtE2q7SzI1zXpBMc3CRkNy43EXPXy+R2VMJib+OoH7TK489CpwmiNWESCzRrySwds+RK5rc/bkZMUlquPJq2ZQGGKvowa6CiyiR30eSk2fb/XO470VKR2mmIshGbk0vaE2naut4JPbpHgDtij8im4NYcs8Cm3oGhgDzjq38s09NSc7f2dgbNnqGB8Oeoavm+eyLYwwVHSGSxTUZ5aL46ISJ2snQ82qhpwZgJLbBWhUjs/hzzM6ttJiZRhQYu+1bbtnG68WpuHHQlmaczFIA3oxnTqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcBC4PAEBRqQBEqRcgCx9LoehRIDDFuHbDmTJ//+yQk=;
 b=ynmF/RbBNVkFiaSnmQKxmBOYiYlwpC5UQchzqRbPn+KmXmPDuGH6Hn/7d3iAc1/Po0Fl5EkqMgy7yoFMAo+2ry0Fhbc3x/N5VWYONZkBC37Lspnb+LmL8wTPmCnIzePZt4qeYJZOOFKrSUBILAz59Uu79pmqIEfP/H4rgMNR06tgroGMjx7Cp/b07qEXmQjeLkUd7/xmvEXefoWcF5l/deVYdOpLDZY242AHzpl1qTX0+WH0ERnV9YuDwGmQwwG6fue08+O2BaRlnnJLZXFSrJY5dX/vB0G9YwNoUKWnj0dJk54nZS5fSkYy1a1QQXuHR4ibbJY6f9MowsljS70dTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcBC4PAEBRqQBEqRcgCx9LoehRIDDFuHbDmTJ//+yQk=;
 b=Dx+aYuOzu9dl0C3/tLdO7UjEuiy0BC2wzRHP3fRn0aX0jAXEZ9DMmlvrSiqeg7a/0n/So1UaL1+poZng47oAh5A81ywDS97e9eLdscSKxGQctf5tFHYCl3ym4eBw/Wq/AML884oAdamFqKlhBhoL/1rZQx2I1xZORDhVRj2g52A=
Received: from BL4PR21MB4627.namprd21.prod.outlook.com (2603:10b6:208:585::7)
 by MN2PR21MB1438.namprd21.prod.outlook.com (2603:10b6:208:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.10; Fri, 18 Apr
 2025 01:13:12 +0000
Received: from BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb]) by BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb%7]) with mapi id 15.20.8678.011; Fri, 18 Apr 2025
 01:13:12 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v5 2/2] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Thread-Topic: [PATCH v5 2/2] Drivers: hv: Make the sysfs node size for the
 ring buffer dynamic
Thread-Index: AQHbriXCp7c6RnUv7UaONdK+rUmJG7OooSaA
Date: Fri, 18 Apr 2025 01:13:12 +0000
Message-ID:
 <BL4PR21MB4627622A03EB8E5D68EC20E4BFBF2@BL4PR21MB4627.namprd21.prod.outlook.com>
References: <20250415164452.170239-1-namjain@linux.microsoft.com>
 <20250415164452.170239-3-namjain@linux.microsoft.com>
In-Reply-To: <20250415164452.170239-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3ba185b-74c0-4b7a-a4d0-3a03a59ec9a0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-18T01:10:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR21MB4627:EE_|MN2PR21MB1438:EE_
x-ms-office365-filtering-correlation-id: 9e6c6465-8b50-4116-3a90-08dd7e16304d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rvTkl3sgIW9yGmBI/X8/vbC3FOGxq/EelfxBTkAc7XJro8zbNuU5Pf/9oTcV?=
 =?us-ascii?Q?thog4N61GabOQ6kTRtD4HAJkuOKI3ZuziQ1e6AezXdM1jGX4npcqANw88n/n?=
 =?us-ascii?Q?h6PfS9bqarzdCkwBtw09G6IpE7NnNFD7Kbx/VmEJKx5UvxEpW13QYadlysiS?=
 =?us-ascii?Q?diqyu/hgzMbAozao8WqS76UaLCxQggHDWFQA+z+RPFmqcCn0tgpGLrlK0c7z?=
 =?us-ascii?Q?Z7kL1BUkKR8LWuASM71rhofT5H9nRMbLgNwrXcA26LSaQMDXdbKPr3T5nR9h?=
 =?us-ascii?Q?dbsQCSaXa+i2w/OGKT0LVEuEgY/ES6qOOcMSiTrbM6DU3PrpT62J5CNmXK7F?=
 =?us-ascii?Q?3xp1NRx5I9qH2wqrlkwOABvFuZZdyk3Z8a+8q+1B1oZz7JmVA330Vjc3UPYe?=
 =?us-ascii?Q?eVK/63WvllSJd62rUwq+TJzCStBK4oVDXuw/YnX4Z4f0pM70biYoTz4jEFwB?=
 =?us-ascii?Q?7VBkXnrx0IIByJ7GTj0DE8cwh9G8sX4Xend4ph0RVuRfNub+vcjE+MWgkYOu?=
 =?us-ascii?Q?ddO1mS7xlVf53BvR9d5Gjv7GNG2tAnIb57EJI7lRtCoUTcK+x6jtV8fzBiG4?=
 =?us-ascii?Q?wMLQf0YiNtaDIiMMEKqBlxsNVXrvhJj7raD6zehry8OSDf3R3Hv0J0YP5/EB?=
 =?us-ascii?Q?5nExwABjgoNtWDVVz44QjalOzh1KZkX6dCcV+1IWUfnfWNQU/y81HkyW2YU/?=
 =?us-ascii?Q?q+V7yugca/uqI7U88lQ4gfHHHvM24joqUnIx94kSp3BZqkKw+onPOrNTohmt?=
 =?us-ascii?Q?ixa8O6fZOKFhzNnvRY5mo4QSznurQCsgr28JTIF9K9PjVq4cmMjru/rH311M?=
 =?us-ascii?Q?KT/Mq8sSpHWaAi1tj0fMeUdBd1qNYyglZYUNHNh8cdcRYiT18VNeO5A+dfbM?=
 =?us-ascii?Q?MN8KZTuW5RwOkboQ5l8LFOj9Fkm/a+9iEqqgKZgUqz37jT/OZXXgES75CY79?=
 =?us-ascii?Q?F7gw6MxmNCAps2C5iUQBHYix5cqSq32eViQ2P8Bb638EVZh7zv877MoItjny?=
 =?us-ascii?Q?uz8baDvwLSjlN+4ltr5/3uPzZk1OBpwuHGgFC01pjUlYB7Vd4jhzX4zaRG+H?=
 =?us-ascii?Q?fN6TYWvNz8VUX/HiOsopdRiUkZAKyjtiiijcCjL1CyOTiN+/rS7uk7BdOtpz?=
 =?us-ascii?Q?CgpE8ibVAOXzTX4MCQuE2Wmi8qzVCXRugePS6hTBDvKlnOlOoHOqgs672iCM?=
 =?us-ascii?Q?BoNpPwZyNNeXAu61IpH7oGKiiA9DsKbBz973FLppcEq/djshtfiNHCNTTtCq?=
 =?us-ascii?Q?1Gu7Ealv8cREHrMyves0bxWPtGQT3W+cvDZSa63iAMdKW+eIr3Es/+AInWWB?=
 =?us-ascii?Q?kh6MiM0aKOE6PlnNUWcCBYzcY8GGXKMhgqItj08mdz/0Kvrg8fpi2v1VMw/O?=
 =?us-ascii?Q?3U7SRYJDrJm4AeOGBEO2nPxUilMPRdkmGbL2BhxJDku8Y6BQwXiy2ffCM/U4?=
 =?us-ascii?Q?7t7OZlKxEvnLX6B04230t9Cw5eUAf6UJwmBqAAsn9teBo34wfT7raF9qO6RB?=
 =?us-ascii?Q?lAGRbuINuLoFhHE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR21MB4627.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NJenlh/8S0P6MctHR+hclBEvZ/wxCe2MmSrRKD1qoh9EjlsTkahxPi4L6Wal?=
 =?us-ascii?Q?mZsSTfbPSdU/FEnd/bnMgSfOeoKzIlhjI4C42uUXmdlpR1SdlMJ7yt4H2eWw?=
 =?us-ascii?Q?k+HJatgm/+ZjkWWaYGz3kw3VguvZl08dXiL/qXizcRe6NCUc2hQl3ocFtKR8?=
 =?us-ascii?Q?OMBFMtZ8X3IQNxrDyTCBacyevcN4HccTERGiiZatR958l0v7iFWj9VeJI1lx?=
 =?us-ascii?Q?ohHAP4mlRKbcs+t0vrwNP0FhwLPWFDHVHsGvY4UtJ4M91Z4EoAPhBTt6y8Vm?=
 =?us-ascii?Q?4aa9sbOC+FLH2RbnZUCQfK53RLwhjg4xv6flMoWlwMeNRTGU+Uyj/X5RMCHa?=
 =?us-ascii?Q?H1wwF7ULqxfI5a4YkL6m2m53YonWZZM+jty/bRyD+8YE26U1Sm+XnnSziN8S?=
 =?us-ascii?Q?j44VYbLt5URiF7E4kfhVUgyu93ef9+eq2j0crIuh1Yb7mITrMHHA5UDuklHM?=
 =?us-ascii?Q?qzSkjL6KKGs+zsfyKr5M7gSOTFMqVDl60MuLfIBrONvijGHdao1qM1YGpT08?=
 =?us-ascii?Q?0zeyWo229vgR5WmTQvJj++rOYMwacOAV7u7je72oLXxhp8bkJ5dV8GjDEJs2?=
 =?us-ascii?Q?HHYhlYVCK6/h8z4sNj/dqFdwjUXQS9jS5EqshddiBwhF9ndT30EVgjT3yQZb?=
 =?us-ascii?Q?4P3tUS4h7zXy9lb/kdaT+kJsF3Duja8hmNlD8+E+2kWSGXy3FRDuBxYEF2CT?=
 =?us-ascii?Q?jzY0sWX71bZEtMzbbtwU9iJu4ZrRuFvI75bMjOQoCYTgvd2LTpwnrFDbxzB9?=
 =?us-ascii?Q?rS7Uxp4b2Iefid5+wLc3uD3sU5qQfP3TuZONlE74zYzrxXa0MiFszaus0NB+?=
 =?us-ascii?Q?6cT7VK+QFKaiUKC1aH++PGrF/tvihLMvso5XvzYVpMJl9m5sj/2joKkJUTpk?=
 =?us-ascii?Q?ZZDqeJ0VVakNIibSyHMm3Bs2wbdcwwQWoeqC21ffYzbzhQxOYLLXII+gJfAY?=
 =?us-ascii?Q?HASfwzry5eAJFqiGyA5QsnUeG4H2C/Xe4TaKGMpZ8Ir08FqWVRVj+yXkKUbo?=
 =?us-ascii?Q?z7FU8dDog2CrovL4YzfzOe0IX+UEYF0FjmGbi9z2plTkrLmiK5RQQm0HZFZE?=
 =?us-ascii?Q?U4H28Ljsr2xLeA2EG5v9sNDsfEQH/s8D21vzPfOs0mLeY3a/G/aZ9xvkhZZ2?=
 =?us-ascii?Q?bvDBxfKLTq90hAIMjZKlIBblZfzK8FcmRAKQ2SbdePWtnJjXWB5rhVqcc0Ic?=
 =?us-ascii?Q?IsEgrT1UYFJQ17NxDEMliuzLCAG7Pryscx6rpjtDsPBZy39mP173EpyN3/g6?=
 =?us-ascii?Q?1rJGcTi5DjkeI2O6xWDnswVf22Sj08Hx50nemaS0bq+8LcBNzdqMCLQiLX2h?=
 =?us-ascii?Q?WGA3ZAdhNLV/25dqNaazLwOyg/gbL/TWqcLZc9wjRxNbZfGt2yQhkuZMAf5s?=
 =?us-ascii?Q?Z0JKB5KMWnqEuc5KqsGHLhjVnrGeLatEMtGR6hw+7brHV86S5ACFMbV4o4gF?=
 =?us-ascii?Q?G0Oan59tHej9puJqiFnttz0oHLkjVndHZMXcRle0P5qoAakPDqQOkbMwKyKB?=
 =?us-ascii?Q?r8T8Xt9WSacoW5NSBgLc3QTnMBgrq2NMgiLarS0g9GeTcJ4d7Ul7AiYoSIRT?=
 =?us-ascii?Q?Hw/VgFuFdi5Nk/0agOp/YgbMeVddpzD7ZIielsSs?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR21MB4627.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6c6465-8b50-4116-3a90-08dd7e16304d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 01:13:12.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kQsenMKH8coTElUeVtst8slPcqAqBN+9ZbLqbqpjt54t5l0KvyYCBKnbI8+FgbXjY48tpEYFXjJOT2KtkjxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1438

> From: Naman Jain <namjain@linux.microsoft.com>
> Sent: Tuesday, April 15, 2025 9:45 AM
> [...]
> actual ring buffer size for each channel. This will ensure that
> fstat() on ring sysfs node always return the correct size of
s/return/returns/
> [...]

Reviewed-by: Dexuan Cui <decui@microsoft.com>

