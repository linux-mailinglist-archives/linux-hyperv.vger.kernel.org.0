Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6764A921F
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 02:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356557AbiBDBsf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 20:48:35 -0500
Received: from mail-eus2azon11020022.outbound.protection.outlook.com ([52.101.56.22]:18808
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234520AbiBDBsf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 20:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYz2L7HLbxUybyoczErI06+V1+EQhbEXdJ6I3YqS/3Ra02YIvVaCXc/Fnu04yXzSRYuhRrsTYWFOLd7dmK+HodClg+6r7I4I/0v47jfbYASS1NsGLPhqRU2ktv4ug88w1CyAyDs02hA9ckHOp7AV9884RRw5sNmK0KXeftaMuHqdUxJa/mQZevMftUcWLGrIoteIA8SL5eGppmcdAC8z22QSMORplXwkb20OIOxcIOPQ8dwa9HE8N2EkNNuwRVI39FpbpwT2nAgOaiWKYbuB5aphuzkuxxrHXslituj7To+hYv4z+1wXdrb5BHwDA6WLhmCBv9Mk2VpKP6ry+aZ+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUEbRIR6sCdSFp6MmDx3PYahN9FvI6sV9tZ54ERJGTE=;
 b=jtBLrYy7+3CsikPlKtL3YqD0KdzDh7KEWqUQDoT+a3ru9wR8FndYB1+PUhMLzm9XZ6bbIuD5CtBona/OgjQ++HWH9rM+AP1JlCnXgJPxzeei3HFzCD8rtz0aS9RynKNu3c6iRPf5V+Uydxnk34YD/rM6qYrMKl4ZTOfzl+HbzOultDA2SEdoRod0Xl11nej5xmmF0S092HSE4IOIj2E4liyHl1s2900ofcn3OWvBPbp05PwK7EoLTQ7IEvlXrts7hJCg4488L8YOcsEzmtenPAQqir19Ns+E5359Xa5sI9xxI13JrUzGWrInaQKcjtl9jxCPaz03zN4FWr8DZUSoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUEbRIR6sCdSFp6MmDx3PYahN9FvI6sV9tZ54ERJGTE=;
 b=fJ/163+xx55Nqk+YifDWSGwyWnMt3i8C0gjcn0YmjHqT7k+1ajBMlYRNC4LaeHyaIpgjyF5CrOyUGmcVr/A1F+Y0kjjU5oolhboCW2CQTaWwDvpy2tkWpNjUzSRhdclA6sXoHXTbhq7Y/E3NMMIKM39Whb/QvO+ycMPXjhrK648=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CH2PR21MB1525.namprd21.prod.outlook.com (2603:10b6:610:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.6; Fri, 4 Feb
 2022 01:48:32 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15%3]) with mapi id 15.20.4975.006; Fri, 4 Feb 2022
 01:48:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH] drivers: hv: vmbus: Fix build on GCC 11 failed by
 DMA_BIT_MASK(64) expansion
Thread-Topic: [PATCH] drivers: hv: vmbus: Fix build on GCC 11 failed by
 DMA_BIT_MASK(64) expansion
Thread-Index: AQHYGWJV1isHnBog/k6ZL9/WRcXRvayCnieA
Date:   Fri, 4 Feb 2022 01:48:32 +0000
Message-ID: <MWHPR21MB15936A0F46747D81D3CBCC12D7299@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220204005736.3891190-1-vt@altlinux.org>
In-Reply-To: <20220204005736.3891190-1-vt@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=29ede0bc-2351-4d23-9dd5-14399151f5d0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-04T01:42:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beca42ae-8cdd-4933-c970-08d9e7807336
x-ms-traffictypediagnostic: CH2PR21MB1525:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CH2PR21MB15251A295CC093E924E58253D7299@CH2PR21MB1525.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXYaS8LB8SxRy89NnmNnH0Zvh/+5hbxECcZoJtXINta0QpB4oa/f+ncPS+ybCA7rFhaJG45lcowJmgmNIBPFMKSduPlG2WRAgomWud+KrMd71NYXdYFPZ7uMKbvG02TPSdeRUmzAE8iQ9DCz4Z/51S1VAGG3oJcab6gI9jzDLHo99BkY4t2z6aEzzn4374aPKgJx3bv6QqMvWOCZwIOVzSMKdm7Kd25nHAitTIp2s87N6E8gKkU+xaBqoud9W9LE+rbyx3lBlxtK8IZOhq9p8HohYbGh/rOqVVlUUuP6tP0RzeegognbvXtH333ssakg87m7eqMNQVoa9gC90HmK3nq/KHq/yZOgePs0XMpAL+dUPZZ1UCQJ59Gk8zOv3GH88LkIRJFUSt77+/dYYej0QoBQFcglFd4OXNxkpUMV9EfAwb/isX2HLHfyscf0ht4AAsWbpGLROryH99NIUHO1178PqPIHCU/PR1dFr0JhPur8tmvqDlkV6PuL2wwD06R+Z3Co7fikLTx4G/yPnlxYYGatdD4Fdr4jM8CsjS0AQg4wrjO71YweItWQyF9xPUYjeENU1vgHzyudfGq9CE7E9XKTLaZyKDCIJ8dJcFrf2ljzGAFALZhpQIzrK1SIHPLttIgd19Rs7CBuR/4ex76VdOnVCJnCDiUofbcv8wZDHtrHpTLGCJk/JBbRjWoTplhCGqSj8fvzmT4oxIBHAMb+Zk2gpCd2yTpvZ8IYbjkjmUFD0RhP9Vc08kJu4ngjzn/1gNlS5mIncWmhJKlyIRMPdBsstZRpe8m08DjVoWbL9YTkhNUYVNajqkbXfa9NiUAMNAlYb2F9hb3VWTFztNGtvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(10290500003)(8936002)(8676002)(55016003)(316002)(33656002)(7696005)(5660300002)(107886003)(2906002)(6636002)(82950400001)(82960400001)(110136005)(186003)(508600001)(38070700005)(54906003)(86362001)(26005)(83380400001)(8990500004)(71200400001)(6506007)(66476007)(76116006)(122000001)(38100700002)(52536014)(66446008)(64756008)(66556008)(966005)(9686003)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HaAe/D23mUzH7k2rlwU73oib8ZTGNcM9YsuUxMlGeAeSl1JgRkZVqyTK19Rb?=
 =?us-ascii?Q?tBPEHFn4yaa2LorLhHNZ3v6XGe+KjJi8hl50RpNHFWglomP/3NVsCQ5JYud3?=
 =?us-ascii?Q?eC1ASVTm4FqgbAi7r9Nh4XkH72pCW2cG+qvP6GVGt+zJQ73a0liPdv/R8XQb?=
 =?us-ascii?Q?LM+D+yYzKasLmYMuRukD1/Hf+QFeSL9ooCsSfP2VXWvZKXOuqlD/1nBkuI/K?=
 =?us-ascii?Q?gEWeUX3JqhVAX01l068rPJpmgHMmLA1pLzG59g8s534baIsomNuu9MT48xQ7?=
 =?us-ascii?Q?zB+2kbOyYk+9YI/ldHHX0RH6Fyqcx+cB+WeO6sO4zmNilaN5mj7EaYAtWM3N?=
 =?us-ascii?Q?RT7cuErxGGPJUSgQCkHWKetFzHRcrHT+KBkPm2OMVa/7mX6pK2tkw3+O6NwI?=
 =?us-ascii?Q?x1gaKEH+ZIiiMBFp+sDcgf3MadM2ALqJQ4tMb1EZehMdDbTK4ZYyNFnpnigy?=
 =?us-ascii?Q?xx/0RYkfoDpRbIiFc8h2u0DeWQstHE8MwtOjerrLqOpnzL81N8bes5coNbTS?=
 =?us-ascii?Q?vh0mbGD49Attm4pPzoyHv8ly9UxiBAc2D6kw2O8zpCfT18hR3JWDMTmmu6NB?=
 =?us-ascii?Q?KDwdNRjlXGk4vv64xqJLn2mAQVBo/czT9pW3YTa/LNlUnKVU6xtIifoW2wEN?=
 =?us-ascii?Q?xNgdnNjSfubf7/Wpq8Ywt785QbAsWWvHyHICL5Cn/hI66GtabDdWqFUBHr4o?=
 =?us-ascii?Q?Ce0kp27KB9bcrhRHvHqj362tvqKe96W/Ac5vVL7fsdRPNmnspNvUQzU1MA6U?=
 =?us-ascii?Q?bR1o3FdPLz3KCAtMZsSQGHwoc+n3P8cYCXqq4UPJvutSGptxxxXSXMFmY43o?=
 =?us-ascii?Q?WyzlwF7V/AmyCjxxGYfOZnngWVJU2QcExc+7uW0S4QZkfDHE9uSHaSOwnFlx?=
 =?us-ascii?Q?xoOVEQYijvT07v+DMOjAG7jlli94Q/83ThC/EPZmdeXsGHQAIbMThw3z0nuN?=
 =?us-ascii?Q?aepp+DEn0FrAzqjA/+OXfNV3yx7OZbYdU/E+eWz1XDxUd5etpeg6wQSnBtqN?=
 =?us-ascii?Q?txpoDCElutD9EkRWU/7Z6r3uOfSj1F9H0v77oNxy8OTkrN/6508n2M41MZo9?=
 =?us-ascii?Q?9QKVqttbigrn30cWbWMZfShYc8epF4OmPfDFpltZwoP7cek9LyzOOto9dD18?=
 =?us-ascii?Q?lFzrudji9wXqDQI2a9ci2ie05hx8C864bwaxb8PVuA4NmO3PWp2DF7UsqL+U?=
 =?us-ascii?Q?iU/mEVdxsosR7sWv8t3qmXnv8NCd5i9NOF4EsOVBiHa0/j24EnrEqQLF0p4y?=
 =?us-ascii?Q?kNsygv5JpvB0Tc2YqLtIu7b2rTmzJ24tnXfKyHLiEWcdFXeeswd0hKc2lp07?=
 =?us-ascii?Q?yPHZ2nDElQKjebOMCGpf3XQ3Hl8QZ4AfvVZ9aHOcRlIVYolqlWabriK6o7xb?=
 =?us-ascii?Q?W7r584Y07uaNM6gYLoAv0LfnHmtzXC7kHmU2+c7eKBYPj2lLbG1N3qmdVfkU?=
 =?us-ascii?Q?kHMbNu76XsXCVRpPh84kWWV1cWz6vlk1+d1oLF5pj4tLkiaFHRMSwLpAKqqK?=
 =?us-ascii?Q?ytUZ0s/CTcQGNhzJYNm97fghH9PI8u7n0Xst9y0gTmZuM7LjEbRVBubnen87?=
 =?us-ascii?Q?wm2rk3SjGOuRUujNWObzEoPk+Cmuo0kT2BtUjubT5MNCSssVy50x+J/1FEG7?=
 =?us-ascii?Q?Ma82CVE/Kv5X0k8rspLGRCdR6K6RNAXI6WlZmXVyQ/W7yTb92SMiHJqot+W1?=
 =?us-ascii?Q?pOlqrg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beca42ae-8cdd-4933-c970-08d9e7807336
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 01:48:32.1754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ut8f+NneqwCExdu6mf3BKhbRnaqSv6zRLmWn7Zdwv77t+Q3rYIIIkdtQUYNAXiGHCRSOAJt+C55v6mrTlGuF9z0HbqWdapl13AcHTBJD72U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1525
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org>   Sent: Thursday, February 3, 2022 =
4:58 PM
>=20
> GCC 11.2.1 cannot understand that value 64 is excluded from the shift
> at compile time resulting in build error[1]:
>=20
>   drivers/hv/vmbus_drv.c:2082:29: error: shift count >=3D width of type [=
-Werror,-
> Wshift-count-overflow]
>   static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
>                               ^~~~~~~~~~~~~~~~
>   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT=
_MASK'
>   #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                        ^ ~~~
>=20
> Avoid using DMA_BIT_MASK macro for that corner case.

If we need a temporary hack to solve the build problem, I can live with
that.  But I see 230 other places in kernel code where DMA_BIT_MASK(64)
is used, so I'm wondering if this particular hack is effective.  We need a
more comprehensive solution that fixes the definition of
DMA_BIT_MASK() so it will work with a constant '64' as the parameter.

Michael

>=20
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Link: https://lore.kernel.org/linux-hyperv/20220203235828.hcsj6najsl7yxmx=
a@altlinux.org/
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 17bf55fe3169..2376ee484362 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2079,7 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t =
*type,
>         return child_device_obj;
>  }
>=20
> -static u64 vmbus_dma_mask =3D DMA_BIT_MASK(64);
> +static u64 vmbus_dma_mask =3D ~0ULL;
>  /*
>   * vmbus_device_register - Register the child device
>   */
> --
> 2.33.0

