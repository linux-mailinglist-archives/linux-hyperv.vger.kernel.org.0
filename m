Return-Path: <linux-hyperv+bounces-6057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C21AEE87F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 22:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D3C164FD4
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033849620;
	Mon, 30 Jun 2025 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EA68JQxh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2072.outbound.protection.outlook.com [40.92.41.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30F10A3E;
	Mon, 30 Jun 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316415; cv=fail; b=d+hb8Exb+/xePM002AKi+pmIV/1cO9xKw1gTYp6NZeEJxC3Xr8tDT091XNiOS8fnsaL8bSd5a+iZ1n7PHNS9yMqOqwpr7Mewq2wjIcgOztE5I2i7l5ThSdBHWlYj7ZPAx1+oYn1nYrzSSkwUaxIM3SKM+NudrAwIMBebnJ7Vd64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316415; c=relaxed/simple;
	bh=adx4cqx34oamWou2M08d7A85FiDJT7FvYg+ErIdhOwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s24HrgZI6Y8q7vabAsJ2X5G7uRBAr8PuqGnFaTOZChAVFX1waxqXEcIbGJovpYIHcRDKs27TMU7j+pJrPZK5QAw5+3rnDJmJE+3bTPaABTg6jwMgl0eUvYPFfQTLR5PJrqyJn4b8KFS5q9ZQ2Ic6Sl+G/UhP9OQ0PXegIJqchY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EA68JQxh; arc=fail smtp.client-ip=40.92.41.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTGFQ26T9c8VecKweorfm6C7in3ecoRTuTgAp232ghcYy7btaqI66Hv5G6qDCcID5FSMCd8rNh9uQcp+T8SYZC67Lo6BHxTFgdrUMGsbiThZXpvZCTA/zzfgDfb13utWY6eWszgJAV7mJ1f0yuhMZ3hihR1Eyjy8osa5Glt6nCuB+wUf/wh3aS1VVB00AXr1bfTnce/mYT89EGRjxwNQWuiSEu5zPESXWhnKXxXPvp7fI9r90948kmkcYvcXoA9es+ngvZB1QLJ7ic0my/u2NTjC8RbtvPJq3jf17FOLaiYyBsw4ga51Jpw9Szrps2e03kECJcxg0Qxsjk6f2+mKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzGh8FbaqatExHMRKPe6fo6H6clv96IH9hBFYouyiVI=;
 b=hFqZku6jUjrKK+yyaa23sCBbVK98qq4ivDp6/ss74Ggt8h0+9iVkonBTym9wFbz7UTTIA/NPc9p6AnvoL9heeY+MMdDT5d16/RGj2+csc/mmltyA+WaQzlQOFCQSTMLZPkIxBIrBS9Uhu8L0eEUQmEFALEtD2uOTlq89zjUzIwaJom73olADf4sGccakrhW34nQHO0m/689HU4x9JoFSXURMTOLO2WfR8cnh1EskIIAQ3xBfXTI2fJexQ+F3YPTliuv8x8VVjMWVIf7HKk6/SMR8iW1TTma/zT7S8AH0K+jMzU57hfOlpuXFaN0VS4AuWgVNX56xSmqeTQZnb4ui5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzGh8FbaqatExHMRKPe6fo6H6clv96IH9hBFYouyiVI=;
 b=EA68JQxhKk+HodRFTwNdGsOMzYuKrtWx2aMKfLaKxyd+KWAApEJTl7lQgknC2Xh/dNITInCWQqdZwpS4g9c8aSgH2Y/vkNKTtRjkqCaOnfY04e0wDzqhUKAPjL12jyV6lJznpVYvoG0J56CdlvMXXZE1QfQ9VqFQPM/swej/3at90Rfiojyc+hilq60b/sa1BvYfadBLEPN6Dd1lDwVUHjVISMFIure7IYoLnlUFo45AWJB+wBLvOo9UAXO2cug+7ZCnQx5jPyxzeAPjFGHvAz16iiUd7UCx4y+OmrlIZWQz6+Pxtu6fbeoajYrp6r1NsE4kkXaguQCQxjE5yJAL2A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB10688.namprd02.prod.outlook.com (2603:10b6:8:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 30 Jun
 2025 20:46:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 20:46:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "deller@gmx.de" <deller@gmx.de>,
	"javierm@redhat.com" <javierm@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is
 enabled
Thread-Topic: [PATCH 1/1] Drivers: hv: Select CONFIG_SYSFB only if EFI is
 enabled
Thread-Index: AQHb3LcUZbs4Go5A40iSjCeFlbXwYrQcRbAw
Date: Mon, 30 Jun 2025 20:46:51 +0000
Message-ID:
 <SN6PR02MB4157773351091649D5AB5D42D446A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250613230059.380483-1-mhklinux@outlook.com>
In-Reply-To: <20250613230059.380483-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB10688:EE_
x-ms-office365-filtering-correlation-id: 55eb3b61-e761-41e0-143e-08ddb8173dd7
x-ms-exchange-slblob-mailprops:
 RlF2DIMZ1qWFvGXy5Wd3Amq47uHZe3CsAyO42QerHSFKqqozInLLWdIt9iRAG/nd8VAmv/rNYDOkcwzsNUQT8fOR9nLr6hW+IVwiKBnOoDmkeWy3kWn6ce4bZFap/6Y9+Vw9qpDDaxEjpgT5sIu4AdY9MrUBnHXZ6tPcAZBiAFKMVS9Hu2+znleWPiYvoOrcOFQSjjH5uNAXWdFJgI5VqXY8N8X5a6tNWgyuCjSXV6auWVco7LQ3ZpaJwtZY1Otf2MKRJocivBSAKdRENtK8nZrxwEqISc20gCm2otXEYXOo67WjZixUJx06Y09xTfAT+cneOldceaHRJeOoG9Aw5hLgOvdP97ttTGSQ6WCXCdkFZtIp6QqLHCw8ujlr4+dhcQjFPOKpjLf6EwhfVYoNKHrkCretUrB/ezMJ6qo4E3XZK+xLq2XpJGzrjcY+X5YXkZqgGdKWPe5NKZoYL4DrvcYp2fSTTvT1UOAt/FMKl6fxR2mufMIz9GW9laeAem6IGijqePYh1YvLyXmlZIB1fIm3WyGWaO3HAaHw95Y5KBGGcFcR8Tjjm9wpY1jLpvc5I7SwZhHNsl2TObLN4BpLdCz/YmKRHydmEiktgThIYMhiDMeq6sYSnl6MNwIzPvXMoXzM3A8tqVBT64Z2sn8ZUT8JoIn+FjDHlN314UBSKFF4q9RsdRvaYz/+DWAGixBDklkRAP63MQtmbs8H48nLCo6KqPuHbbFOxdhoGkeGyPc1PRBST8j+pnrZrbPkuAmu9qE6y/q88CpyamM1RtUIs/XwzBpkZ2+xyz3Ha6JffKicn7+DT2AfCPFG2nwC9TX49RfpqP+p0Mf2A3CfgaKVofqLbhLogZCJ
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|15080799009|19110799006|461199028|3412199025|440099028|4302099013|40105399003|51005399003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2aSRMK/yazn4MmVAYkQaJPdGBQbDTU/twi9eqaWUzzMDlaIzQl+ajwaYvJxa?=
 =?us-ascii?Q?dqjecEgQmr1dMYIWJF8/EOyOJqhC8PRAvpWJfXDkqpDr/8IMwb4u7X/6Jyfh?=
 =?us-ascii?Q?YTVbUhXZM1+Xajvo4uh6eQ3Pz8PPpTc1JC18CGHHHhoiFdTc5EDAXCZW9kOv?=
 =?us-ascii?Q?sEX2/fiFemxR79YItBmd6oHbmPJ5PxSMkibXD1JaEPKCpIpu0hrs3BkCgpsv?=
 =?us-ascii?Q?wZgowc4YMbgwRsoKRrDx+f3rqkoNWSkLCliSEyn+szmB5GselCB+5B6GeapS?=
 =?us-ascii?Q?brldwvXyyPIwzAwCYpveu4AQ7j7is53Blz6v07VnSCwuvDPPJmWBtE7kZUnI?=
 =?us-ascii?Q?xcPt+k9bcWW948OKGWfJP8/ThPCjhb8BEimHz9jQG608ieyCtPnoNoWOQgVv?=
 =?us-ascii?Q?YLW5sjbKsnvQQFm10cpPh5WCQoeb1B9YBOglsO8km4+k96V8d+Iglq07DdBT?=
 =?us-ascii?Q?iIxbMCiFCKKkrLrmMgt3V605+5ORRZl6GhZTBCGAp4VD0VRcp8wwE0zpoJjl?=
 =?us-ascii?Q?P1L+cmSEwJZ4SIoQOYLj7YLOVchaox1vT82r/V2KeC+9Io9OJzpzbR2Op8Xu?=
 =?us-ascii?Q?Y5a4mNrbRemZHwjFXSOh2TrvsyktHF56V8q6N7aq8aFebxL/uM+es+u8bi9B?=
 =?us-ascii?Q?Pih+duSyFfyTqEWydfn5nH5cxJxq+Uw36jCbiKiNJ6Q8JTTwZcORCEPs/dtB?=
 =?us-ascii?Q?eejNRth0/OQnuNDZkYAV3HUsSxTZuxjM/49LuQY2egPkmmBnPCGPd12R1EFZ?=
 =?us-ascii?Q?79ERI0xZ8nXtf5XA8yIPmCGaX/CoDhBaMzEhNlldlYFpbVk41qwwrrUpKotA?=
 =?us-ascii?Q?B+e7qfd5NOFAIrzy9b3fh8b5WHuYqwCzAThGM+uPyFfs8plVQCj5d4cuJSzQ?=
 =?us-ascii?Q?+FJgGxnsj+gneRpPJu/LYtZhKaWBMwJuHkQ0xITtweGb/5MFp3w9vCi8NjG8?=
 =?us-ascii?Q?9KNNO3U6aD9FVtTSubgugST9D0mHIsifXD9CdEeh8gl/yqxER9R4Cqwm/YhD?=
 =?us-ascii?Q?U4D2NUAMWC4GSAFi9wovaLYhueWYUlLaFdy7W/C328CmRY7zNsFxl/UHQkqu?=
 =?us-ascii?Q?JNn5vp6wKhuAL954pyQlNxxC5irCNXQ1wfY8+dLcCrp23a93Pr3SnMUUXY/t?=
 =?us-ascii?Q?q6cHKzPN/lYghWEozJl4fAPnnLKSSLDVX69n58YezDVeI5j2zEN/EPkwE1xG?=
 =?us-ascii?Q?hvKKrDX7xGPfmEn9XWWBCkFxjKM+sbdn/frE+QmUJonwNsWGO5LhFWSeW3lK?=
 =?us-ascii?Q?R2L0IuVrB9BMLJ/0LjsuXLYnpiO045BaeJ1j4VErnw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?teAQ6JP+EzeQUgpB2IQnUz32pTT6QsqQqLeOo0ezQUIQ0gMCj6NLLfcmmDP/?=
 =?us-ascii?Q?NHV0HJaFaat109jTWp2lQCEMZxbGIt0YwDyd364VurwGhn8kZKzdbRC6sdCu?=
 =?us-ascii?Q?BqN61R4jdmOC1TV/iwFuVoYRPXIcROy+W6C2GiY7FyQtRc219cBrTutdAFg3?=
 =?us-ascii?Q?MG6Ha45BlL7qL21xMQuFykhFy+fYud2IGiT5/tEjGx6YnFVD3OBqUe0+oQiY?=
 =?us-ascii?Q?4HoPC365spUOpFUsBcJv+KJHnZyXAT7T/ZqWFEhGWcFjIDOjT/tS1pWKL9Bj?=
 =?us-ascii?Q?71klTscCSt7nPewvFj5e72qtRNIA9NdFESayGivnCAq44DtExfswNgbSZINz?=
 =?us-ascii?Q?ncEmOx94oltbc5vXNqeBBAIyDo0t2kA4DAnwzSqmIqdk6aFAEnQVIO7dV7qT?=
 =?us-ascii?Q?TO4N7x0j4ipZewIRm0MQFsN41U3jvH+2bqwiPkd3QvLgiORBb4ZVhU8/qFCd?=
 =?us-ascii?Q?POZJWBZ0jjeAxOE2vjnZEWYgyi8g/2IO41UUbJTAbD5gYE90bw9Sn2pGT5Kz?=
 =?us-ascii?Q?b7GD/jE9XuZAiGucQXIBOt4Ta450lZQAyuqsiC2YG9D2mQZmXLX8mGwuRFXi?=
 =?us-ascii?Q?Mj+0y/yVQF98tb2L59f6/ot5M7zB2PGQrCVWIJ/0gVhY8/LJyffTy7pNwI9d?=
 =?us-ascii?Q?rSUp3WAGGRxhLxYmGsbYHxxXMMYEeJ3bi5X3c5/n7g6rXMA22+kmD986ydyz?=
 =?us-ascii?Q?4MnHRmQNefwAWwiGhjTMg0uhM9tjng4jVCjGYo4nvSaGNuDIfY+W1KifiDsN?=
 =?us-ascii?Q?JmwL6jQQv4VaxjobxHkn5a6BxOKxjb1jAb/hqxDCdjI1fBA+Y4Co633jpBzm?=
 =?us-ascii?Q?Om1vWxx9RwO/39bIGOYw9A5QnOqKRq13NSLhGYC8ZT0YoGVf1q+GzQwK7YhO?=
 =?us-ascii?Q?LHvexvVUVAKr0z+lHlDYyZdNbWPjQulEntwdB7zKRp1VqL/RD486lYrF2w5T?=
 =?us-ascii?Q?xR5lphmiuC0AW/e7J+XHYaviDTlX0iXSv+1iuKekF6b9bSpkWCfQT5WfUCbD?=
 =?us-ascii?Q?VNJgouF6kac2BqVexnJatMd9O6l3mUF09vZHqHU/hGQN4p06sGw/9MVnOEA/?=
 =?us-ascii?Q?iw3lmO/u8ln0c3pJ6sCuduiFQ4KtpThU07uly9dJWwQPEs31emHp6MYg7f3r?=
 =?us-ascii?Q?uHmoqGqHsKSNZiaTyTOyM2alTQzQPxDF6rJiw97x4re9HOkID5zA3nKou2YD?=
 =?us-ascii?Q?7YRbCPiIgIy4QzHVQl01+yNQvL3cnxX2rSBsT+TvwppB613dIct6FizTeyU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eb3b61-e761-41e0-143e-08ddb8173dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 20:46:51.7498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10688

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Friday, June 13, 20=
25 4:01 PM
>=20
> Commit 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB
> for Hyper-V guests") selects CONFIG_SYSFB for Hyper-V guests
> so that screen_info is available to the VMBus driver to get
> the location of the framebuffer in Generation 2 VMs. However,
> if CONFIG_HYPERV is enabled but CONFIG_EFI is not, a kernel
> link error results in ARM64 builds because screen_info is
> provided by the EFI firmware interface. While configuring
> an ARM64 Hyper-V guest without EFI isn't useful since EFI is
> required to boot, the configuration is still possible and
> the link error should be prevented.
>=20
> Fix this by making the selection of CONFIG_SYSFB conditional
> on CONFIG_EFI being defined. For Generation 1 VMs on x86/x64,
> which don't use EFI, the additional condition is OK because
> such VMs get the framebuffer information via a mechanism
> that doesn't use screen_info.
>=20
> Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V=
 guests")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/linux-hyperv/20250610091810.2638058-1-arn=
d@kernel.org/

Arnd -- Can you give a "Reviewed-by:" or "Acked-by:" for this fix?  It
needs to get into linux-next and then into Linus' tree before we
get too late in the 6.16 release cycle.

Michael

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506080820.1wmkQufc-lkp@i=
ntel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 1cd188b73b74..57623ca7f350 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -9,7 +9,7 @@ config HYPERV
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> -	select SYSFB if !HYPERV_VTL_MODE
> +	select SYSFB if EFI && !HYPERV_VTL_MODE
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> --
> 2.25.1
>=20


