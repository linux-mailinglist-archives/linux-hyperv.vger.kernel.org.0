Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530EC1EF2C5
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2020 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFEIIU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Jun 2020 04:08:20 -0400
Received: from mail-eopbgr1320134.outbound.protection.outlook.com ([40.107.132.134]:33757
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgFEIIT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Jun 2020 04:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrRxccQHCMWKwhwWJItiUfgzgb38mIKcWkab+V3TJILcXF1bimnn3J0880olrkgxtmt/ncSEcESnmSLDUyxivoYHsOQ6tlIbNZCx1gXhN0nO6iSyrSq88jWW0AwqQblJ20THQiJ8GxkD1/430qv4NTPJljnL94BUqzBuESNx5P4vgeVWN7EsA77YlTN95TPSlZjyJcTdvEledSXma9/KzFob+PJaNyB0N7WBYL6X/omjB6tWLJkkL3rKeDn28LeDj4GRZNQW9t+7yx93ot6tdN5cWUKXTCUAJ4raortOsYbI3Z//pDTV6E1SsqirHzJ5B8ReeQCzdtgLuFsl+MhI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDFMXAIl6aXHyjHTKS3V4aNdReoVw0GlhlTp7+6lAoQ=;
 b=d4LW6AHSdwow3gkLhuXMqjcKXwg4Gk89GSWLEteE5liKfRgCs8cpkNKEhbXYK/7sxLAlLO/D73V/cC6pnZiaWCorvuWpt4BHeTdSjZ2Q8D+r1rntjqbjKLAxO45aGIcqRXBgcv0kG+5nGSArFDsA4oraFe9a0kwsU8L7dhovs2sqEV7yjsj9WMwez1wxjHV5z5paX2Uh12auaDKnxiAf8a/+jmIcCjan/Yb3BFNY6rtO4Ol05DGSarNAUFVPl/eN91pdMcEgrYGEeCNfeiwKPH28BPBQ2Yub13PIVBikIy0H4rq/OrTT51qbfDRZXhFV4H9DWXRUYk3CMeajj8QjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDFMXAIl6aXHyjHTKS3V4aNdReoVw0GlhlTp7+6lAoQ=;
 b=MzzHx0N3LY9z7Jo60KewAoy0ptmh5q9ZB8k7B2ZOFK2kGL3jaFts7lAkRBxDbvV01faeFZuufv2qWfa26M/c2RbrJNtce5H91oAsPZU6jMw2HCRfEBQqyhvmTxw12S2rzMJLxWo18g1IuDx2d72MoosdgIWQinupkDHE0lA9cXg=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK0P153MB0179.APCP153.PROD.OUTLOOK.COM (2603:1096:203:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.3; Fri, 5 Jun
 2020 08:07:56 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983%7]) with mapi id 15.20.3088.011; Fri, 5 Jun 2020
 08:07:56 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Denis Efremov <efremov@linux.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Remove memset before memory freeing in
 storvsc_suspend()
Thread-Topic: [PATCH] scsi: storvsc: Remove memset before memory freeing in
 storvsc_suspend()
Thread-Index: AQHWOw9FnOyuSXdfiUiTPbK6Paq606jJqmCQ
Date:   Fri, 5 Jun 2020 08:07:55 +0000
Message-ID: <HK0P153MB03228CB6B766D5FF30FBF751BF860@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <CAA42JLat6Ern5_mztmoBX9-ONtmz=gZE3YUphY+njTa+A=efVw@mail.gmail.com>
 <20200605075934.8403-1-efremov@linux.com>
In-Reply-To: <20200605075934.8403-1-efremov@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-05T08:07:53Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=32441352-9973-4b90-8951-239ca2a9e099;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e404:4689:ed94:8298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 998a2855-04c5-49a2-4754-08d809278e00
x-ms-traffictypediagnostic: HK0P153MB0179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0179DB49481F4F49BB19895CBF860@HK0P153MB0179.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++0BFT54S70KM22qW1dtfJPCAou/1km57TCFP6LwPQtgAfno8RbWz6ahAbWTPqEJI7mVs5VnQ0W6N0aQfRR4dVFH92Lm6TuPON2GC+GwqBf/PY4MTxTGxHcSzVobKzuPvMrTFgS5pJ5MCWpnLQa8BN6e9WBwp/iUSazDxsMdEjHgkSbXquzjTN4vDoFxcOcuukAaLOtjsZFoRvBXPBmcjhUlCE3MSQxRBAFo+5Q+gcqQI1x/+2P6PNWEz/9AByeqlytfBexBQwqk0ng06bPauTBc9l46hFBsLSJsxPj+0v99lpP1iR9ON7k30wOalfRRqIn1yuQajrrhLa2urucavA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(52536014)(8676002)(33656002)(55016002)(83380400001)(5660300002)(9686003)(186003)(66946007)(8936002)(6636002)(76116006)(64756008)(66556008)(66476007)(66446008)(4326008)(110136005)(86362001)(478600001)(7696005)(316002)(53546011)(6506007)(82950400001)(10290500003)(54906003)(82960400001)(71200400001)(2906002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X4E2mZU2JVikIkir8/qpwVTTooi5Z/YbxsFbadroyuKLAvhSmGI0gd3+kmuQc1I8NcTsRJHzF1lzCKnNpFORkxV+Vgc/30apVDdR0vHvQE2DGWu5CTTqRBRPS1EVaoR0UzqCpYVT6UAtdIWtoDNZfNuUVzSbVjbdnGn9H/wp0QrBB1S/SxcnFlhvDn8nI7KsaxAEG7NnXgnF9IQJGTwjlL3KavtwKjvLr7sqO6JBIRLM6uj0y/7FuTSLl/WCrSwE/kETuHwhlBynm530AuZB/GPgjxf/FTTI7fHwFgdDXoHORXzNCPb+MAyAk6YIAfUu4SfW3JBMGL25Ots/gS1zpXctUSR3mn9Bu16X/fVURCC3OkZPW6eDytU2GTW63qd6K0QcUwMQGys9iRew/QYA6t2V4g/LymyyfCr1DE+oKsP829QPVfBJMQjbukHT+PkpPYkzfS22qF7R6YbU1UcTfRXoB5QlXAwvdL60uWDUGq7V7WayXiYXtc3b2MKVyOyTGZrpLVBJcWnz08O2DrzgfyLuKntuso0RjXc779RLCm9wEZnemds4i9fSYgKrTitW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998a2855-04c5-49a2-4754-08d809278e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 08:07:55.9305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQtxlgFT16yRBwDatl5gyAZ80tA1S0STEB7diwxrLYFl37cmbrSarqI+ap5lXB80V6z7++QRqI/s16zo1+oKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0179
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Denis Efremov <efremov@linux.com>
> Sent: Friday, June 5, 2020 1:00 AM
> To: Dexuan Cui <decui@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Cc: Denis Efremov <efremov@linux.com>; James E . J . Bottomley
> <jejb@linux.ibm.com>; Martin K . Petersen <martin.petersen@oracle.com>;
> linux-hyperv@vger.kernel.org; Linux SCSI List <linux-scsi@vger.kernel.org=
>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [PATCH] scsi: storvsc: Remove memset before memory freeing in
> storvsc_suspend()
>=20
> Remove memset with 0 for stor_device->stor_chns in storvsc_suspend()
> before the call to kfree() as the memory contains no sensitive informatio=
n.
>=20
> Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/scsi/storvsc_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 072ed8728657..2d90cddd8ac2 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2035,9 +2035,6 @@ static int storvsc_suspend(struct hv_device
> *hv_dev)
>=20
>  	vmbus_close(hv_dev->channel);
>=20
> -	memset(stor_device->stor_chns, 0,
> -	       num_possible_cpus() * sizeof(void *));
> -
>  	kfree(stor_device->stor_chns);
>  	stor_device->stor_chns =3D NULL;
>=20
> --

Denis, thank you for fixing this!

Reviewed-by: Dexuan Cui <decui@microsoft.com>

