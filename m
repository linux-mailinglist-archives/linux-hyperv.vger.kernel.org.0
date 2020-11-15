Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18212B39D2
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgKOWRC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 17:17:02 -0500
Received: from mail-eopbgr750100.outbound.protection.outlook.com ([40.107.75.100]:19634
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbgKOWRB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 17:17:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhGyPfKyDwIzaomAjGGiTaXovIEu2svyYx282kD4efRPg9cM+cNjWogOM8Dx8QNoIzRBXo4joyitM1gXGF0rw5LV+t0igsRw5mVrIqxb4DGs8nIztCms7RFqHfShqEC27AGBr0Fpf+hj14LHQlHDcVWIOOG3coSPJuWbmdnpNXpiC3pmM3maxxRoDipDToAYK3ti7mVsrZvQM3M/fDFHlC2KEEJu7Fyrjhgglf4GOYHQIQJHlZYre3QewOba4TtRdXRKbadAlpMwdH4c5+2fmX5zPKVndP+NG3jMtw7Waeovul8ld6yqSagffLZTOsPgToFS+8Empw84U483ySM/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ3lXwaFofruFwKg+bnbtaonsh2DZZX7V9aPcajkBF8=;
 b=R3Y4hePO7zD02DMssZhMKXytoE+OppLhpJEfH+qQ7U6uVdFiTXzyHuDOeup4eE8x2VhwNrcNQWmDVX3US98L8IrqsxuZDhWaxFarpMgn3+akaNQngleCBPiL8UC6gzqhtoOjfamaUvUt5vKw2PSkuEekJYS9EFue6rVBJEDW3FxTwrUNgCPM6ShY4B0fZ9AOZrBS6MsjA790OxplRfAmJpaTXl6HvZ+6GS0Md44eSlEBMcTZfS+CreuXKBL8nj7TJW2bFw34CDXoJRLq12uuCmKOGt+yItkXOOr0imuWVu6LwG+xTYEUFOsNMhAdQ8maayfNe9EnjfA6IufI6YJOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ3lXwaFofruFwKg+bnbtaonsh2DZZX7V9aPcajkBF8=;
 b=C1OVUwMFW2eApy7/keBAw+gYIh4VSc5CK4ZTQEc3tVw6hA6oEpyHVWAFwv1Nvmqg9yW9EBAhpj2+BNIoQXfJTdAmrS/r+Uo75BYPUDi/kg/C2d/UZ9hHjxFTF+U8Gmi79Kosrd0v/6uRTmEuu+7HAvjOjKHQMmulXi6FpzoWsVM=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0890.namprd21.prod.outlook.com (2603:10b6:302:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Sun, 15 Nov
 2020 22:16:52 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3564.021; Sun, 15 Nov 2020
 22:16:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] drivers: hv: vmbus: Fix checkpatch LINE_SPACING
Thread-Topic: [PATCH 3/6] drivers: hv: vmbus: Fix checkpatch LINE_SPACING
Thread-Index: AQHWu4mw7ksyYBltFEe6yxzBpE5BFqnJwqXg
Date:   Sun, 15 Nov 2020 22:16:34 +0000
Message-ID: <MW2PR2101MB10521EB5B3FAA2A9EFEE7DCAD7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-4-matheus@castello.eng.br>
In-Reply-To: <20201115195734.8338-4-matheus@castello.eng.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-15T22:16:32Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56bab26f-3ec9-4d6a-aee0-dc0033e4c4f6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03a15a07-7c73-4b0a-7d79-08d889b41d29
x-ms-traffictypediagnostic: MW2PR2101MB0890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0890FDE6F12C2C72F1C9892DD7E40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:64;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pc4lj7Ko4rH30WZfTbszaH0XMM/Kjh1ghlUwQM9HTbsZ8WQSkZD20FFR7dj1DNdQrqqTn6QLsI0FFjakh/5bIzpxFsBkAOKLF9PWlOO9gXWcm3SjGir4rAZEPOUOfUffTS+orp/pZDhpG/0RnkS1guURnMrdoCb67d2CA37J8zCEbMubb/osZjbAximnWNcevNn3BBAKW5T10reRYnJp/r33h9Q9EOfrI6FzGdVGhYedA9x47PlPRXu9b3gc+ve3RhDLRqHngeI2BUsC4Q7y4J96RjqPy0Y8INPdlUYEoXeUHhkKltCVoY9DQ+y1SznC9gF/P7+VmcqSp22I/kOqng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(33656002)(6506007)(54906003)(110136005)(71200400001)(55016002)(86362001)(8936002)(66946007)(52536014)(26005)(8676002)(10290500003)(82960400001)(66476007)(316002)(8990500004)(66556008)(7696005)(64756008)(82950400001)(4326008)(478600001)(186003)(2906002)(5660300002)(76116006)(9686003)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VEv7Lu9DPs/r7JWnsUzbcAdW0hAwA5E2WPeNJg28wRNphB5gAHpxZ/s3GeX2KVbUg23jUujIFhImAblNV3d64OA9YzdZaA849QtVBC/nnGQX5FJ5KX8PkQ3i6C48rq3na0tfKd5P2Uj6HKrt0pkgMWuDFzE8zSIXMA9CBdePiQNjzTs6MQ3He8jpw+YusfuXYJ3348kls6NHpDRVPP01w3kurGRncEBVsVZueewRm1mfhEN7aFt2HvdQMH2ALIkdCyMlrXWrhUFYShXY//bQbH3axXQYxMnIQX3PCPKfIxGRtYxekbWRdbdqvaXVHpTpy8mNJLZexkDQWwiiu2r4IDjJuMbPBJZZF0fU1bFgiQwH9mYNc35Su6GW2NacEjW9vEv7qq533hS2KuCQ+ycJ0lEHBBOIjYYoMXDwpH/3zgIq6Oq7NcfEUk5k7zcFZ5u07hyWBLArR7kz1+qxf4VL2SnLn7fKHEGk9L+i4fHbpT6XPGIeQhmgmKzMSXx3Zm82NYDsYyF4WKXCR4pHWzxU8+YGodcrcmGhOVNlTYyLNgiTOPZuXMDE1PZjFXmZx4P7XATPzgE48QAGluL+oI8EsI7uERkmbp1qJ90plivE2tbIX8oKd72wfYOzGeHJVsu0V0zpxxCjXxYC0QwuM2xbqtsqK7zKMTRXrXH4MT/d47NTwEQLFd10tyER5YtkvO0JTaQjmy1/+7zjLWLEKk+0xeujHYwYmtS/WTXIyqWTpUMnCjej2DvvajoMTewM4mSezMnZJuLlAr9fljsZOsecLBU/huzLk93zAG9xxh9ieF5yuomXu+GghzIbUmHud1FudOQbrHCnz6EkiCKA0XyR7ZVMn5V8lsZUfXOWYU4VuQtY+h5JZuWTC7EkHj0FjGmWXEzGhmBNAl7xVZZ5M7Cp4w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a15a07-7c73-4b0a-7d79-08d889b41d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2020 22:16:34.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idLc+wBg83gPrQvqV4STUpNiaxUdKbM2I+qmx4gDHS0ZxgG8NYIzH23werWXwouhTcGaREP+d6xpnR/7ImgO8ltbeuDMsWoAaiNcrOy02Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br> Sent: Sunday, November 15,=
 2020 11:58 AM
>=20
> Fixed checkpatch warning: Missing a blank line after declarations
> checkpatch(LINE_SPACING)
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 52c1407c1849..61d28c743263 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -156,6 +156,7 @@ static u32 channel_conn_id(struct vmbus_channel *chan=
nel,
>  {
>  	u8 monitor_group =3D channel_monitor_group(channel);
>  	u8 monitor_offset =3D channel_monitor_offset(channel);
> +
>  	return monitor_page-
> >parameter[monitor_group][monitor_offset].connectionid.u.id;
>  }
>=20
> @@ -550,6 +551,7 @@ static ssize_t vendor_show(struct device *dev,
>  			   char *buf)
>  {
>  	struct hv_device *hv_dev =3D device_to_hv_device(dev);
> +
>  	return sprintf(buf, "0x%x\n", hv_dev->vendor_id);
>  }
>  static DEVICE_ATTR_RO(vendor);
> @@ -559,6 +561,7 @@ static ssize_t device_show(struct device *dev,
>  			   char *buf)
>  {
>  	struct hv_device *hv_dev =3D device_to_hv_device(dev);
> +
>  	return sprintf(buf, "0x%x\n", hv_dev->device_id);
>  }
>  static DEVICE_ATTR_RO(device);
> --
> 2.28.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

