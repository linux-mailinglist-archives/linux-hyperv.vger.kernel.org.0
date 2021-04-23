Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4B368DA7
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Apr 2021 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWHKd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Apr 2021 03:10:33 -0400
Received: from mail-eopbgr770100.outbound.protection.outlook.com ([40.107.77.100]:35123
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhDWHKc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Apr 2021 03:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVHKOGIsHCGnCUV4Yo4B0XRioUwGjYCMhmtyl1BQcGUtamj6eXo3dvs8/0sAGutrVAHCnuQomIafhGMLUIpZXQoVS/dlQt5AbdD/pSQ0LiXhb0O4LLvBeEjATHqIqDqLRk8TJgsVfquj/irhehfSLYZkE+6h21hx6LmWbq7Xhjc1b1ztKkRc6VYbAxwRuZGbGdXG1+x1mHKknyQlZMt0SkRq4UY3+36zdwB/qqY4iJ6katI0AIhoggPjSIzndeWdyH0KcXCPjV4Nz7oS8EY9uRSBjOpAr6DBHDGYGpnyZpdkS2msBkumspvBglqhr23xt3uDLe0lokc3OpNSVjrCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuPIC0sRHwa5Iz0QwQzLLyQ3S3RgYymNAdUz6GwveP8=;
 b=jos/UhVBp2nUKmMSasaoCAYg/8y8fsmsFh8zQGLq9ehCTEHJ3Bvrp4ZuBQjs0hCGTnstL84CcXQ4M/9HpTNCdpGUYLqPcTlnvUKurt9Byr9R/Kyc378OdimsVtAOhgJ385dEpWkZX4sYxZPCAl1Ra8TZYNfYiVgddsaPLmc/26W9rk0VhvpjadceeBu4cbn51Txqsjz95h3411ltdsY4zJhoZr+KrhsgpqVBdQlTr9Wkz/Z9qV45N+C9MMCz6uSEU6bdNxIwf8wnc3kGxCZ+pxwPffcsntRb/Mj7/ZJH67hA9WobbnMrCoWFyxq8rWb6otdJgrQMsTeNbOT0GcIwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuPIC0sRHwa5Iz0QwQzLLyQ3S3RgYymNAdUz6GwveP8=;
 b=HZL0eyDxluxIbvkFF9OLtrhIPclLtdHWSCdh/evvMOzfRh4Ruz1c582iEynYFOW7jqN4xi4M0IRFoCTXUK80p5LvP8sDDityA5WbzV3THFjzpo6E8MVlgKPljC1+R+iPkqNRxCbjY3wS90kRi21X852gJ7brg/yVmAWzw0PfZGE=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MW4PR21MB1892.namprd21.prod.outlook.com
 (2603:10b6:303:78::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3; Fri, 23 Apr
 2021 07:09:54 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Fri, 23 Apr 2021
 07:09:54 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXNzrEqHm1W7VddEiGdCJpDqqWbKrBrccw
Date:   Fri, 23 Apr 2021 07:09:54 +0000
Message-ID: <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825368ff-303b-448a-ba43-6f3872c68267;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T06:58:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:753d:cc43:efdd:9f99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a8d188c-7683-48bc-4159-08d90626cbbd
x-ms-traffictypediagnostic: MW4PR21MB1892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1892B2F866DC7AE6F1B4B0D9BF459@MW4PR21MB1892.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsVyujXq0mYCHhlMu/+TszeQP7wlDIoLV19x4nPJiSzPKXrN1Qu0pogUYMzYVU0Xg4xahH1RHRSn4y3dEyn6ZfHXRxYNJWRfO1SCNw7b/EAo7awZOETo4dw+0tlvVUmFK6X0cDQ5Adhz3Pk6MDJg5POvHW1PL1u+wnEcRzB3no7ON847np05u7VMobi6CC7iktSozcCfOmgdaIi+c/QPhd8ywvjXzfDcpaY3cm5pGu9d/DDCKxTdLqIUbLM85Kefb6DRpxTCzX6yZuqCI0kUbLLodVHlJmFWb2/Y5+eqsUa5Y80ZXfqgKcAJXVuf0y50iI7VNktB4GHks7APD0zvJVGBcy8U7x2gctnlC1si8FEqc/C9OvgFBdlpkKtpg4y+m6N7S5McHWPI5tQx/XCEkAv/MycEM+IAu5KZyWp49PuERTb5SCsdnebzSw1TUmLKI6og7y6/SxV/Jz7RAEQL7HRaC+qEqtStHsiutuesu377gBjNOddrmnaqkJWHYMSvL/aFDWxuEiOinDRAm6tZ4zWdip8Zyz0cWdqEC0vx6aOrDyy4QRrV0bnGhMoYEKZy5xX1+DCC3/Ey5OMJEtY+kJ6crmQ25mRpSrpYrTbrDYlBV+Y9yrEQOkarynVOpuwXDXfRWXGddfsp9fMFvQtOrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66556008)(66476007)(186003)(38100700002)(5660300002)(66946007)(478600001)(122000001)(7696005)(8676002)(2906002)(6506007)(82960400001)(82950400001)(4326008)(55016002)(83380400001)(66446008)(8936002)(110136005)(52536014)(10290500003)(8990500004)(71200400001)(86362001)(921005)(107886003)(33656002)(9686003)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ValJQfdflSToH9r+oGEpJX9aPgi8HzD8IdhWaihYCnuq/OtBkr4QVWVVkpoi?=
 =?us-ascii?Q?9ctSfobnLV4Ml+w4w/R9j7OIeys1+Sj5kRapMYEGIdWi9Q6RI9PsL8CczIau?=
 =?us-ascii?Q?VJV30qbkdQiqka6Xh694xuiBAwpqiQSamog0wpVVJOoSdZCVF2Hj8cxQeO6E?=
 =?us-ascii?Q?JmjFFPwwhn4B7CCCQocUTGKDv94AiFYietEIL/L8R16zwrnpBEcH/FAcib89?=
 =?us-ascii?Q?vasVoXODqXSmoefD0LiGKthrekj6ghPO482ogcxXqtnb/gAsOrnzH7O+PyiF?=
 =?us-ascii?Q?eu5V7m9WD2429eVpX9v8S17u12OeWJGhrsd8/HVm2HEK6HfhgclDKVoKxS0n?=
 =?us-ascii?Q?r9HFQwRV+/GhcXjlZCWIvXLH7WnNokOYQpIeHJ5sV/ONwxl7YGtzUs2nZUmc?=
 =?us-ascii?Q?CXWffaxs6la3dXe0z64MW9aBrtd0AYjbn/y7DQHVV58/p0plNfyMd4VblldV?=
 =?us-ascii?Q?+DmFhf1qry2bsmp0N3MThiDCj6a8X+MQOmXsA43P1/CtQRwNCAEjdL4LRM/v?=
 =?us-ascii?Q?jlOWsRG4bx4NTU1cgP2UfIJndJt6IXfNde9bO3gUTIFuW/vb13aX6S3r0mOJ?=
 =?us-ascii?Q?jmHVNv1QRM6rxaVpTslQ2ZmmFsx8NpGQfy/Q95+b6A8k9F3zU9tP/VlVprjb?=
 =?us-ascii?Q?4vNTDwuy2t+BheIW3bPkt/I7dVO/mXCT32HDZ8mJz1SqQnORUMJlCczc+h8u?=
 =?us-ascii?Q?suYW2mL07+je7CRCAe3KZ4pHnF2I5lhn1zdOaYDwLmqRbiJ5YUTM0qesI0gE?=
 =?us-ascii?Q?KSlhtXsfWSqZOtPTVs/vco3NRWF1uaaPFblCxPYIJpvjRSJKstMEtThaPtGV?=
 =?us-ascii?Q?RLUrfotuoMIYBqgJG207ogf/wlhUc7MaXqeBSLRCg/cCqGjW9wRMpn3Aci68?=
 =?us-ascii?Q?m+ogqlDkOp0zsTQkC/l1c6y4Sbp9RHqf0N4jN9Qxln+zcEIsii8CCU/gbnyv?=
 =?us-ascii?Q?y5A5N35AFrg75+QvFlNGNKShaxEu0hSBTt2CK1PHzZTLDbrx/b6Ch9UtR5NX?=
 =?us-ascii?Q?jZEy8vs2skoIvAmKDV6UlWQtaAq4dmhgmroTR7uVoug3UPemcXfGkKMH8SwB?=
 =?us-ascii?Q?PGZIxgMlpQZHmTmYxUH5kdTCMryEC0XSdRifYmUAxD+6QiKJrjHnCzCvM0Dv?=
 =?us-ascii?Q?UBRV1BiBqwe0WMgFBTB6R7FgQ2zfUIYEc3LuPZAGLWqeL2hLO00QPWs639ON?=
 =?us-ascii?Q?C/kcuNVZndsiH4/qsWun4s1hpX3EvLNg87GGwS8W+wC93PhvfknnQe6nGi8b?=
 =?us-ascii?Q?1tVEmdhtjOyBfTmcCzfichCLacc32H5p80Cvma71FEUiZLNeTi8yXMtEoBuF?=
 =?us-ascii?Q?PtA5SDLKbBxs9CLjypzQoCNb+UqUXbqdMTh5gw+BEp2PR+VsDcvLFbnrdNMa?=
 =?us-ascii?Q?ClkcurCB1FBbeKWIuUKCkfNcUo5K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8d188c-7683-48bc-4159-08d90626cbbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 07:09:54.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JvAzwKcKNEVMNZJJae5DB1vMaFf4ZBLkJlhX7n+Yuk2W8Zir4a7lFQIPSVQeSBUFJ0vs8Ul9QRyUfRyRqB7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1892
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Wednesday, April 21, 2021 10:46 PM
> ...
> diff --git a/drivers/pci/controller/pci-hyperv.c
> b/drivers/pci/controller/pci-hyperv.c
> index 27a17a1e4a7c..fc948a2ed703 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -444,7 +444,6 @@ enum hv_pcibus_state {
>  	hv_pcibus_probed,
>  	hv_pcibus_installed,
>  	hv_pcibus_removing,
> -	hv_pcibus_removed,
>  	hv_pcibus_maximum
>  };
>=20
> @@ -3305,13 +3304,22 @@ static int hv_pci_remove(struct hv_device *hdev)
>=20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> +		tasklet_disable(&hdev->channel->callback_event);
> +		hbus->state =3D hv_pcibus_removing;
> +		tasklet_enable(&hdev->channel->callback_event);
> +		destroy_workqueue(hbus->wq);

If we test "rmmod pci-hyperv", I suspect the warning will be printed:
hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_start_relations_work():

        if (hbus->state =3D=3D hv_pcibus_removing) {
                dev_info(&hbus->hdev->device,
                         "PCI VMBus BUS_RELATIONS: ignored\n");
                return -ENOENT;
        }

Ideally we'd like to avoid the warning in the driver unloading case.

BTW, can you please add "hbus->wq =3D NULL;" after the line
"destroy_workqueue(hbus->wq);"? In case some other function could
still try to use hbus->wq by accident in the future, the error would be
easier to be understood.
