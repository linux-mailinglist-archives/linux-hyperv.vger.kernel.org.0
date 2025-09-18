Return-Path: <linux-hyperv+bounces-6925-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C3B82CCE
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 05:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77EA1B2676E
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 03:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035E23ABA9;
	Thu, 18 Sep 2025 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f3OoL2YA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010000.outbound.protection.outlook.com [52.103.12.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A518213236;
	Thu, 18 Sep 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167389; cv=fail; b=e2wF1bj9Kiu048ID/t+SDB8nqunT4tZJr0HWA+B9VaJqfGSVnTOLdJjpxl0ty2JVDSnT2DCwdc5/5sh3G6irdaaNtyqVruXVYc5K3gavkfeyP4mKu2VWSo7mOppXoRBdF4zjEJSYMhLFQv2fpxwljcIG2berWagPsYecPGUAMIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167389; c=relaxed/simple;
	bh=aE4vgokQzIl4j7ie4s0Drsr9FelvX14O2PYyYuwCnME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QULPjMGedrVfVHzemUI2fXsuEd0behyGzdhfioKSzse5AuJKVTPpxUqZsgGxgkvI89mJF9Mv8kSXsBwg6RbbSX5/O3dR3cQcOVYsDH0+BETdilNqp+XhmMiqAbUtV1Q7/NbFSgpNmQeMZvKu6ft4EwBCup0vriqQUqTGN7I8OR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f3OoL2YA; arc=fail smtp.client-ip=52.103.12.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg4yriEddsX8piA6LxMPBhhvnNxbIYrzPhsAqhZI6B77Yq5STI5riFQblsBUcsOWmOLe3+DGiow0r03nFIMUnWqod0Q9fe4sd3ty1/1TnLPboJvrShQAZuUxHESH3QdAMqfXI6a4TjUxNRdmhQKb92dx6ZE55+SuidzXz6VaYuljHvTXGC/W4b9q3FirCwoNIeBoG1Mb5oqVU4J1mS81pFgkZp1YTB6NxViXc0YkKMQ33ii7z4Qrk6FH2HiRStuD0uGUOJl7TfpzERW6tdWbepq1AMgPil960ZFgtOqd3TkRruMNeH+h5PcpE+RIblIUF9G+FV9sqPqcWfhy9jE5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIMNMR5AJf7k1ceIvU9e3DLh7S52Awjj/tCLvF6K2ls=;
 b=ju4VPipYtPcZXm3fhCmJ6NCUCeQuxHca4Z6cNTZGxXDGwwM7Fahpithu8qZPjLJbAzS2fpDiePNIMgH1jjwnBui0KJKet14SxHzD4/c8yYLvRZvz5Jz7TOc2OqJYZo7DGgysZPplnnUzABEtduJwSmWSPyoZJeQ/NxGYJWf+FYgvyxfmzIzzjKpMMetwrVp+09YSBL3ZN2trKiuz+ru1X+RZ65npObMt9nCYNHPe/2hLqojdBVTxwiSKq5qWQ3gC1vA/NKoh0p4965P+68EgNzut0sTXDK8aOHkKNoRqGXe4oiRZozK23sAQj8NDIph0b0V35zQ/NgjMwVrs0Duw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIMNMR5AJf7k1ceIvU9e3DLh7S52Awjj/tCLvF6K2ls=;
 b=f3OoL2YAp1W+Rp/IGA1Cacjc8nO+nHJjmvF5myR0loMeoig8QCwTf1e/YP/dyBv66yDCNCeSD2NswVy9BPBdA3BFGSP5pVagFY7Oqzsaavki6UvcMRJh05qeOgp6KTpRXX+zeG7LZqiK7DVZ+pa/9lerxRe9MqpKmD/rzf9OxTeidz154dEiYGo+sraF0dS5kyGuaKjf6Q40N6LqNXrXlPUj/DtK4FkfYGqNCW9eMWi+nnqnqhVgKq1/XLme19B2B/9ThOYziOE3N+7QJAXgPDfdTdVJjx3Je8qXjloiS/ak/ZDWASKKfbuQpPB4Sk0pvuikhVkTDcdxx5gRpVSzVA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9862.namprd02.prod.outlook.com (2603:10b6:303:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 03:49:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:49:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] drivers: hv: vmbus: Fix sysfs output format for ring
 buffer index
Thread-Topic: [PATCH 1/3] drivers: hv: vmbus: Fix sysfs output format for ring
 buffer index
Thread-Index: AQHcJOQg0eWBZhOLMkWvpyK1bBqS7bSYVICg
Date: Thu, 18 Sep 2025 03:49:43 +0000
Message-ID:
 <SN6PR02MB41578F335B9C07322D70C723D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9862:EE_
x-ms-office365-filtering-correlation-id: b26399ef-29d7-4047-b691-08ddf66666ff
x-ms-exchange-slblob-mailprops:
 5fu/r660v9MHSDx/iaeYuri4/Uqx8pWIAarGP15lKnrIBw9RmaJQv062sDYPljk7CNWdV7MVR5rHffJ/KfOmziWlwdtuBEj42+sINaEWla2jqVuJbifz15W+lz0eCpRvZe+2PTKC7axJ9ox+XSoRXIVS2ytPkj5qOj3mGHxqNne4XGJpMnwbKwLIXuPad2Q4m8uMG1yZzKRrcOm7NhRxrLk6BxdQK363Sf1a1gv6MUjq8pFwnWvt+EJtacxxTmyeQTYWmgCUVJhTHjKcgfD/DXhopIzPo4rV1Ue61p1Vlk3RoHp0SwskRpdOWp8FgGZtwz9NQ3+NKo9OCSEc42TqW2dv6kaRBBj96S4RulaGH4xdoWJIB8SAOZpVDtr/WbiCAQGk8OCgsbaccnf3b5WvWZtpxe0RUc42AEKF/HyMIuWGPc/2wlGkOdSbFulxydeCqVOYvcZ3UuLZ8iIK2HIvqx3Se9GgZqe2G9vOUbq1XCbOichxd/1RrESb1r+jrpdxtbQL05WDSAs+28TZDJ43sY3NKIhL6t+7l3tpfo9BfJ1TAL/IqtDAquzU7UIIg4KY0wSjE61hvJHTeqdL5Hp3m6gFg1Out5sXwuoYOgjJn+ep86eKefNwNu508eKd94LwYN7EjjJAHfEMgg38Tr5hCrsKqjG2dcYYv6JzmIHEsVlCQGq7HlVN/ntJTxMj2bl7rPJYr3+cN+xAIllXRXSxcoqyEwe53i56h+VRcuMzYCo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|461199028|19110799012|8062599012|8060799015|31061999003|13091999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rjS7zUARwVSVoJ0F2SIUSyKoVQOClqqcHzmbjZ+zy8aRD0xmUTt9EGibe2pE?=
 =?us-ascii?Q?vBE03XxgM7mLEchGkqlxH2wsDTgMo2ITLLVj+Xgk3rOYgxo7hDoeim+6TOqy?=
 =?us-ascii?Q?1ygxFsUaGa1HldI/jFF3dUrmJLWhQCb8hZ6T6XJlczRG+7kMLk7moUNBLWzO?=
 =?us-ascii?Q?7GLEjb76eY0CRrTA5tg0pyqmZK7WeuKjGp/uv96C4+KXn306EAv9wSgQPS37?=
 =?us-ascii?Q?iQXTgvupSXmT4MVkGNTYDSW71JwNSD3xBMOKi1j2NZ5D+2K72s2oZ4WXjYIa?=
 =?us-ascii?Q?FFyLjlUp4Vxswi/d8QHPBVd8RvcaN2TjvseQWaXaGru86Oe5Je6YA0rKmp9j?=
 =?us-ascii?Q?EAoVZmZ4+X+XLokC8u6EVN0js5cOLuaAhXorB7xe7w46spJ3ml11vyhREUCG?=
 =?us-ascii?Q?UClHFXtQBdnZSmBsef+XcuGn8S8OWZlmt6HRIINDvNbRbJe/EP6gDyrhV5a0?=
 =?us-ascii?Q?uZptQj8z0iwaI2af2kUpWgYbI/wowojlSJdF3FvRjtVLnKxeIFpfg+EmjyIR?=
 =?us-ascii?Q?6omWJpqDsylTyna7M1RYEMxPL+OUH3iIlYkRpJys/pO6J8Rwte5+h8lt/fjk?=
 =?us-ascii?Q?nlmhOmyLNr+9FmCuhaub531Y0WrKrjPQAc7caBSc13vEXokIL0CnSPZ4RAb/?=
 =?us-ascii?Q?bHV8BNfbeIvH1ZCiSyQcmHneWaUh41DqH2LT++BGfkZunT7aF7mNSecKlmtN?=
 =?us-ascii?Q?/Oca+kck+CcIOH2xtpPmNZSs9SasPI1TMAWAjeDZoUw1B3pLXTqjGVA6itSh?=
 =?us-ascii?Q?BeoTmoh22tMFy+qnFMmQQ+bks5K69sufdO5oGz/8ElQjoew/vWzJ8uXm0BsP?=
 =?us-ascii?Q?vzzNUrKW8W/KsiQn/411/q35IjVN/ZLX+a824THIByW9myuN2e9Gy5uEpKJS?=
 =?us-ascii?Q?u65beRZNYZznyAGZ2qfjR0t0s+/14NxptRJ9MReM1wVpyPFNs9t8y3Fy+3rf?=
 =?us-ascii?Q?KpWuC9/fpVkGZRL+HJSVXt62mb26cnct6s8kb+7fXYqB6cbxdJQSIBQdgE0s?=
 =?us-ascii?Q?j5A45RrbIvEE1SsmjMoC+4IDtI4xXrYWrjjxZE9EKqddp9qdR7jpIQCSx61x?=
 =?us-ascii?Q?oveld5PWDoCf56yQTctDjvQysDi3uMqXGl0Jvo/BQtHKCbpyY2bIan8TEtnG?=
 =?us-ascii?Q?Q617ZwJsUePsBfb619UjkIS8GvmemSDG23D7tJZdFULslb2xWcfSxUDcQPlA?=
 =?us-ascii?Q?NRCe3SLpClcO8J+6Dennmh1SQyp/rXN/usinjQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x5d2GxxUVXb5kyoU2eMlpgWb7OjVAlAkBOYC3Y/gxNPEf9XGUwzlYmElwxmD?=
 =?us-ascii?Q?c2NQ5o/qm7Db/UFNfvlVZ2WCeYoR+PIY1efQNDehlF7cwQx84RO9CCs8BoGe?=
 =?us-ascii?Q?WYYYDmCXkbqrruyw7NVohfK1vDyyP8TPEBLppWREvEue2MDLjH3buZgAy/lh?=
 =?us-ascii?Q?m/JJ5GJZa3ZEwaJLuDaRX82BreKeEeWzns33kG+oHmU5u+kRGsNH6BxNtiTH?=
 =?us-ascii?Q?BUNxA7L6LWboe1+rQ+rSge8pPPypphPfim3Fm1S/hLgF62Td6czHSAhxC6HY?=
 =?us-ascii?Q?pTY7BGE2Lpxw7iK+0KAnb+qL7W4xHpmg0XK9cgrNayZKPlrLr7YpwUy3DHR0?=
 =?us-ascii?Q?QzYFYjrk7VOo5Yth7t1SHBBgJbJ9gj0WZGUx/kkp2o5LKtCNU9iz3qvhM7mw?=
 =?us-ascii?Q?YzCAMO4hhNYH66Q0Nd+K9R//sSlf3g27LUMmoXNf/9XMOIqZ/6f3bPAks2N3?=
 =?us-ascii?Q?0mUfYV3ZdMBL1Y1L4jGBi3d5hUc/IaWk/lYA1oXbEo8W0RsfpQb528YWUh7A?=
 =?us-ascii?Q?jAaUTUnsqtbhItjqthirHMxJogRUJu35IULW4QzBT7aXy8fQZP6Gq/m5/OW7?=
 =?us-ascii?Q?ucndrLBkDiOExSOgtyz+SGkGtgPuXI43T75y9ODGmPGrKNLhsKvWJXKQf02s?=
 =?us-ascii?Q?RuKzTaMy14ATTHb5yKJG40ntdY1mFfoTjh5iLur60lmzWCxAgxiBA1iZNsOw?=
 =?us-ascii?Q?DAgL7UyFaPI7hsCRuZ2X18SR4aC8Vnn7GeGK9kQKLqcFC/uAczLc5U+y0WSw?=
 =?us-ascii?Q?ajSTJXktHUsmP1wGIIA7SnOIuyojwlFw4vtlhHuRRAwtIEt//WtauJcNfw/K?=
 =?us-ascii?Q?CL50LYxtEIzWWAP+M00A+VJoaEOWjgeQRyGWO52Sm+6ZJQwW8qj1vH/5cdLn?=
 =?us-ascii?Q?Sw3UV2JCRWkiq1NbXBCSI8gjhWcP23SNSqdOOpCzG6yEVapRdn4femafuTcr?=
 =?us-ascii?Q?QcBLpTRyAmbxGoDm304uKajptBbb9cgQFBAV+AI966xf5AuoLK20pd27mrne?=
 =?us-ascii?Q?idWVDUsSs2+vUP/YiF9s4JUYMiQalwPTmmo1eNSVa5Fq5zpAAKW+oBHo008R?=
 =?us-ascii?Q?midZxTa1pVGlCRffyqASpheWqx0YRe/P01dhTaKlwwxjs+UApk+HbF4HjeqD?=
 =?us-ascii?Q?A5gX8yuXNZFqMyMqWXiiP2QZ5VHuxfsM12hShFjwzf5gXem87pTc7WJTZ342?=
 =?us-ascii?Q?EwLb5qyaSHRWd3qXoW/tqpl/TF3YD8FJE2heVnGazUudU3gIlAVP7f3XNQ4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b26399ef-29d7-4047-b691-08ddf66666ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 03:49:43.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9862

From: Alok Tiwari <alok.a.tiwari@oracle.com> Sent: Saturday, September 13, =
2025 12:25 PM
>=20
> The sysfs attributes out_read_index and out_write_index in
> vmbus_drv.c currently use %d to print outbound.current_read_index
> and outbound.current_write_index.
>=20
> These fields are u32 values, so printing them with %d (signed) is
> not logically correct. Update the format specifier to %u to
> correctly match their type.
>=20
> No functional change, only fixes the sysfs output format.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/hv/vmbus_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2ed5a1e89d69..8b58306cb140 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -322,7 +322,7 @@ static ssize_t out_read_index_show(struct device *dev=
,
>  					  &outbound);
>  	if (ret < 0)
>  		return ret;
> -	return sysfs_emit(buf, "%d\n", outbound.current_read_index);
> +	return sysfs_emit(buf, "%u\n", outbound.current_read_index);
>  }
>  static DEVICE_ATTR_RO(out_read_index);
>=20
> @@ -341,7 +341,7 @@ static ssize_t out_write_index_show(struct device *de=
v,
>  					  &outbound);
>  	if (ret < 0)
>  		return ret;
> -	return sysfs_emit(buf, "%d\n", outbound.current_write_index);
> +	return sysfs_emit(buf, "%u\n", outbound.current_write_index);
>  }
>  static DEVICE_ATTR_RO(out_write_index);
>=20
> --
> 2.50.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

