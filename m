Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC55F41F74E
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Oct 2021 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhJAWM7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Oct 2021 18:12:59 -0400
Received: from mail-oln040093003006.outbound.protection.outlook.com ([40.93.3.6]:51614
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229727AbhJAWM7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Oct 2021 18:12:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxquX71M7WvwQ62O1I5SNtoT5edmJBz1M6vHo5Lwd4V9dPsoFXY7zbocZc6k8YZMhoqYqdC8+zhdZFBQVy5mwIF8wFZhwOOmyAPqG5g/FG+t2MI6WfiA17fDWCrlQGqnpax4I3pqOCjl6FKzOVjRLUppUyjupSOPJUPo43f//ZTGi19LE6S81kzZqFHE9ZN9bt/wUpchyHJeh0ZfQnjy+izq5B0l23jR4OzEskDyLKY0V6PvgABPPzMbbVZ3Vl6pS8TxqekudT1fS5FQRD34UtbDrPOnMFFwBuB46TE4mnZWM2mywsGlZAgqJXHbpDOoO8unW8PUiwJ1/E4d5pJKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdvuIlu1JCAS1+QcAGCr4UwHVP4UPVvMHwYM7+v8POM=;
 b=GRaKdPXd+pNBceZMOjqvOkmTbGNUleT7gC7WPCAU6CzSNCBo5MCE295M0SFAzGw/DrbUz+JUyuLQtqesMTZLpGqsTD32f4//RpJU+OtXDKvWXXpdRzx+/MRKP4qIt9r97OQSwxDJJUBo0uewyBQyfXsLzj68OOZCjkMhmI0CkePSORYnsN68zUPC6XsQIxh9E6/GTG/2BbJGO8Q/7NFM3y+w0M7XugwaZGmRyhq/iFiEekBwLbvchKMsWGMYkO2uHexzmrtxOPLmXczL04jLF67r4QfAa6oVbiAhT221fPL9Is5lZ0zGo3utMpFw/3pX9G5OORAvTIFdxFm6EFyAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdvuIlu1JCAS1+QcAGCr4UwHVP4UPVvMHwYM7+v8POM=;
 b=FbMEj9p42GpkthXOcXMNe68vkgq1hiIm1nxzw9x+/Mf5H2GyzJkBer0wkaGkeLQsKSj0SsKjfGnduYPcnAigu6A2z6nRuV+9RK0+BFaX8MAJmp+MCY8xYbkbQUh4xdXnV0Pqb+3/WUxE27ms7lKRBp0uAvOYM6kZqCdiv5ACZ2g=
Received: from BN8PR21MB1284.namprd21.prod.outlook.com (2603:10b6:408:a2::22)
 by BN6PR21MB0740.namprd21.prod.outlook.com (2603:10b6:404:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.3; Fri, 1 Oct
 2021 22:11:09 +0000
Received: from BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::f8ac:5395:a706:f38f]) by BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::f8ac:5395:a706:f38f%3]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 22:11:09 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v1 1/1] hyper-v: Replace uuid.h with types.h
Thread-Topic: [PATCH v1 1/1] hyper-v: Replace uuid.h with types.h
Thread-Index: AQHXtswbdkTHUlRC2UiOUA37fzDRhqu+s4OQ
Date:   Fri, 1 Oct 2021 22:11:09 +0000
Message-ID: <BN8PR21MB1284A4B993EA1C8A51A043C7CAAB9@BN8PR21MB1284.namprd21.prod.outlook.com>
References: <20211001135544.1823-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211001135544.1823-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5567e594-5fa2-4c2f-9649-ed3354c77ebb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-01T22:06:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45432323-a992-4eb0-910c-08d985285f85
x-ms-traffictypediagnostic: BN6PR21MB0740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB074078D8F82225628BBB4AC9CAAB9@BN6PR21MB0740.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qkI1Pi3/nLo0lm3deZ07LoEajxes/VLI9ESUf3Lbvy/IroBJIVC0aBvZDcMcim3dYXUi98NxN9sXf8qFTMXhAHPgeuW72lOb4JStaGgSZTze+NKdrPOma4B/Z14+oDBNWeCg9UG0vQ6qap/YVheudG52wkIyUv6BwO4CC3nDhH00KrA0hJLa0mMHX1nVbAaYhm5oUkXmZOYrB81YaXuraQsAxcFP5HeItkARd2R14QibmrqIFytxo0cWbfSq0XyQFFbtdZmP4wDN789DirFxU//U4wLswuLnXuxiJXPqXoRb4S4JaWArvsYSP4xp8tASqyJFZKd7J9b3CROjBCuoYYad6nORQnCjuqmkvdwGdlhE4U6AvnMsOsnsjJhlOXvZzAkKWtO18AALfZHduJ44shCAlg8grhQcLEWjbkMlnMWIaTpVMAbTme+nlsLts82vQnshVXx5mmddUyL6YYyxytk01/LZWOk+N2f8epY2b51+AotiX1kWXUQFewaX92TMqy73kbVbg2/CQLHoc+eTvVRfbrrxl72itsQV0L+wF+UoFkI3T1M24pKTZd9qk4nJEHVKBQ3+Qq4xZMUH9rjYePuZvfsekOMThnIdsepE4NwWU9raSApCy1FuShF5D/CkX0YfH8tise5huBcCKEM0P1WFhR2XiCzFyiArpEOTkQ5lfrXNz3j2Z9HxRiy38xXFpPTyAmb7yegaID9Rbd4UGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1284.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(82950400001)(82960400001)(316002)(53546011)(6506007)(186003)(110136005)(2906002)(8676002)(8936002)(33656002)(8990500004)(26005)(5660300002)(38070700005)(86362001)(64756008)(55016002)(66556008)(76116006)(66946007)(10290500003)(122000001)(66446008)(38100700002)(508600001)(52536014)(66476007)(7696005)(9686003)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tWrHWaCocKADmj2QEbi4nG55EdzRjGUmW0d+7HMZcyLfdPBEArg20zWEE5Y2?=
 =?us-ascii?Q?TDnAldknxTNIgq8MEYyh08gDT1En51flqKCJy4bpo6gJj8YLouYAYW/HswvS?=
 =?us-ascii?Q?9TDz7TZuq4aq1rjSjJ4lTn96PggsrGANFcKDhXg24Tgkx45xiXZWSsqkjOC5?=
 =?us-ascii?Q?ur3rBqM1dVLwaXpn3I+NOunHEgYi3SQp7WXzMtHLykN9TfiT3QYnIo3LCmNM?=
 =?us-ascii?Q?18jxnGvZe68379BngvpgitM86CRCCbqeyv146HQgWS0o3+fKvwHbgBsT4ipo?=
 =?us-ascii?Q?viXKcPvbB30ZORsK3Tsb03VjGLpKTB6gpqcNMxNwOuTzAjD1eJKIu0gd5OoF?=
 =?us-ascii?Q?njjCZ6GVSSFAa004sX33mJ3SDDZ4N/xAqt3i4PbnWtMpBa6AkGGPHJcQIgNy?=
 =?us-ascii?Q?Medrmyu6012deZ/5XcFtzuERHH+jfIOh7pqW1M2eYNXBMgXSWzq4UQ84fsez?=
 =?us-ascii?Q?tV2ZrpfQkNmCj0qePDjBVYnFoDtJgDTSJyrX+sEGs1VggvnYDLwsxZP0mlEF?=
 =?us-ascii?Q?X8ioUYjUmdfywHzgdW+ep0b73ie1CHtR25uR0q77TYEgEvmVMvByZk0wwje0?=
 =?us-ascii?Q?Ac41yRRdExV0elIzBPxj72NsuHHsYvLrgj8HgidcyLKkV8DY3OxzjeF5zcCk?=
 =?us-ascii?Q?BY8EuNRuKVLteZv9IFByNOMQLJXECh5TRYT3Ydp3+364NZCRthXL15WvKQR5?=
 =?us-ascii?Q?Dxvmzsci7ffs6k6nJAyv89UMsp2nYBqSwzjusYp8kKhNQ2+I9tXMbesn849b?=
 =?us-ascii?Q?XCv+3ZC0VbVn6jNoV0xWFMyv0nom3v8BXs8HwAL2wP2kM92LB1KfHpCyperj?=
 =?us-ascii?Q?JNAQzujt27m9Emwg218DERy82m11HcP0dHwB6rPqdBHdF92PPpU/qO4TkC1W?=
 =?us-ascii?Q?O5VbaiJcXovnRp7I4QSvHlpSRbuKDv807ct9sgN1iIsU1S1yFQyxNbnOlG7L?=
 =?us-ascii?Q?xw5SpZZPoxwEOj+xE7BxoRaAiRUsZX7OapUA57qbinCPRFlqx1+ZgYvfex7R?=
 =?us-ascii?Q?2MoovzAaOapt+M4mRSd2Y7r7cCl0W/+bfWjMrB8sCvXHLF0rl/Ji/wZEDa4V?=
 =?us-ascii?Q?gpvBYUY45AOG0U2p7naYTipbnjke9woFH86+0FBFQfvMDE+TMSYoErmdgImA?=
 =?us-ascii?Q?cwXx3bY6ircrMcWgaetaAnuMkmv7ZdVBmK91vLzXjKPBEUwkAFYAbQ92ek8p?=
 =?us-ascii?Q?ovKMDMh8yTIcMTuA/+9+PkxeXQkwqWIBlKqCQuvxdxmi+y+V5w9cJgqF3AfB?=
 =?us-ascii?Q?Wa5p1LFs0mnyN4Eg7UWvLEOTkXukKUwxBfLNDjfnnc5ZD85brq70K3ivywmW?=
 =?us-ascii?Q?vFdC9f+DU4lxylM5GEDtQFd6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1284.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45432323-a992-4eb0-910c-08d985285f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 22:11:09.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1GhA9+vB36FDJuVJROSlxiU/fenxytvcbz14moTz5CKFS6wdHkNf1djiYTXNcSp6WFBVFQodYkVb3zDw0yn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0740
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, October 1, 2021 9:56 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Wei Liu <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: [PATCH v1 1/1] hyper-v: Replace uuid.h with types.h
>=20
> There is no user of anything in uuid.h in the hyperv.h. Replace it with
> more appropriate types.h.
>=20
> Fixes: f081bbb3fd03 ("hyper-v: Remove internal types from UAPI header")
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/uapi/linux/hyperv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
> index 6135d92e0d47..daf82a230c0e 100644
> --- a/include/uapi/linux/hyperv.h
> +++ b/include/uapi/linux/hyperv.h
> @@ -26,7 +26,7 @@
>  #ifndef _UAPI_HYPERV_H
>  #define _UAPI_HYPERV_H
>=20
> -#include <linux/uuid.h>
> +#include <linux/types.h>
>=20
>  /*

Hyper-v drivers are using uuid/guid APIs, but they can get the defs from
linux/mod_devicetable.h:

./include/linux/mod_devicetable.h:#include <linux/uuid.h>
./include/linux/hyperv.h:#include <uapi/linux/hyperv.h>
./include/linux/hyperv.h:#include <linux/mod_devicetable.h>

So your patch looks fine. Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
