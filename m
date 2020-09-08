Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AC2621F7
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgIHVbs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 17:31:48 -0400
Received: from mail-eopbgr1300128.outbound.protection.outlook.com ([40.107.130.128]:13385
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgIHVbq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 17:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioClsiBUtNwhYK4g/5kanUSTflxRfmEgqIDd8qrPM/eydRd8wTu+RACHH5ZI/Ghz+5p4nsNUfF67XD9lNIr+UYf8/iy5ekSVgzrUUOjZokY1PSVXMQTe12b+0EN/KGxcFc24smSYVkvU+GCKLDF7NUOVm+LPrQtFuH61vnKd23foECsX9xmuxdLuxqxFGDUz4AJxbo2c1WKmwSIgQvQAKeLX6ZHxiolNsZIgNREGRa1AOHlXCLdn169T9lggAgUVPwTXGiv2b6rHV/4f853l2wZxMc4WHiJg+XtKA/xrr1sARrnzk73mW0LaABqVWm8AIYlFOJwySDf2iuRjyCdfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFaMGWkVYs1TR5LcSCobQquoZfQY3APqcvdXGBQgkjg=;
 b=I1afKXzKBcyA3BbVEYneSmi+Q0gCOdZuZLjz5NIys1Ctm49XvcEMUOXxbrYuVbrRACOVUaRfVH6COzbnrpF5chsq/q9V7ecgbf51N0RJZQp+1AydM0X9KFaAtZy5f5vzkxkIzAwBiDDJrXAxnZm196sfhG0pwGCK4eoKXD1o1SkYk0zBNZz0r6A3uS1YQeneuppvCy7jVk4dFohxNHtsb22CvGaX0OkbJnKjawjBEzqLq1mlUIrxIVvVHpu+WpuWEHLsn0wgWhrUvbzttBwdmG6I2ErUrLwgvCRPl6c4zznEobwV07v7kg2x6P0bH1D6vugP4Bebt6yEoS5puQcMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFaMGWkVYs1TR5LcSCobQquoZfQY3APqcvdXGBQgkjg=;
 b=CqKcgJbXbUYEp/VGqfLzm532mnXMzZjri176MaPjIOahmYP5bo/SVsDjznk1y4BoBNUkHZaJYfRWWQeVzTY0RV5H7kYSGRz7R2LDUwzu2BR4fg1UswHQKArYu3oFTp6+ZCHiJxfTIB78bOdFhAe6YY396TwXXgzQBXdPeNhCcms=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KU1P153MB0183.APCP153.PROD.OUTLOOK.COM (2603:1096:802:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3; Tue, 8 Sep
 2020 21:31:36 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61%5]) with mapi id 15.20.3391.004; Tue, 8 Sep 2020
 21:31:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Topic: [PATCH] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Index: AQHWgzAAQgytpURzi0G46BH/yzzFMqlfQ83ggAAER9A=
Date:   Tue, 8 Sep 2020 21:31:36 +0000
Message-ID: <KU1P153MB01202CD4E9911C68439814EBBF290@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <20200905025450.45528-1-decui@microsoft.com>
 <MW2PR2101MB10525ED3B3B67E619861FB97D7290@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10525ED3B3B67E619861FB97D7290@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-08T21:16:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04fdfc6d-c53a-476d-93bc-cf289a0243f3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:cde3:b0bf:e4c7:806b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aea379b1-aa1d-4392-78ac-08d8543e90a5
x-ms-traffictypediagnostic: KU1P153MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1P153MB0183FDAA57DB2943E1287B0DBF290@KU1P153MB0183.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eifWjKaUvyj8KuRFrlzLiSUcU6cgEa7u6yWhgMyfqS4slzFegkx2jpLBbmzm/sepTE9vtVYAr6MspQ/mNpJcSq1fYjGwzEej9AiASorHZOEET6cBJn+O6ycndfKfEdeTF3XCU+2oUrZ3ouSYMuQB9ZeHGJZYr8qYDUuUnY0wwajVR8C2Q19JMisAE3Uvn/6LGi+14JDr1n+XOczqBILCsBQqcrmx28OEiVsuudqCG4dP1ii3S7JaHdRSCVB6TPjN8zuoScd4bu/dcg/XhjnTJK1+oP/vWciRilYWdII9VJWCKzd0Kx5MbyD3VoH5zzADHvGAATL4UBJFpcZQ7CCUDLX3eUeT//Myq0C9qYF5qnT6SBSoTYUd4gO1aMxtfDoT1wr1ASTEGql2G/nyGG7YR6asIMr8YTmEQaH+o6zI3yw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(10290500003)(66556008)(64756008)(66446008)(66476007)(76116006)(66946007)(478600001)(4326008)(316002)(8676002)(107886003)(86362001)(2906002)(4744005)(71200400001)(8936002)(52536014)(7696005)(5660300002)(9686003)(6506007)(110136005)(33656002)(8990500004)(82950400001)(82960400001)(55016002)(186003)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: htWje30LKfMyAKSZZnT3YPRWivEZgq10h8ycigaBbk4tza9dhbuQBALQ32bdn9YXwwgHiPWjDHztLsovRMZSoGr2PWKgys9tg7HoinMLY+BjyAPx5i6NRttvQnuUwVQZiKHw2w7n3G4eoMG0IQdu7ZfExsLTnNq5VnQnkXjUD8dQTO30CRQ6S7HiOLZkCk91w8zcovyoucE7ZBEFfswUd+GUOasAUBPF0kLNX0erXFH9fRS3XR49VmObnMkP7Xr8JwBjVhYI90mBnuRBZtGcdoUJmEGDpFf8qtMRZ8qXSa6IjfbYZd3jLXZUgrIBY5FlV5hxb6PovpK22J+T/dIK3cjkvujt9f0aeqolMKBsA74xcfWdO4NHvJDhRyI14YAxLCsPn5tve2wHfIxMZ0PS/MYO5q1j+Gd1FmV9QzJ5ooXLZ+cQjOy2iHmmv9Pa3bNI0OtTpVxzAKmzLTCpxrqOOGhHwCK04pvC5mZn7Zu+9XKKGAs4BgaPJQiuYgVTumDdVNzRQ7oYkRKypbLueY7lZP6K3hC4yoQuGSjfB/fIh7ntVfIaFUeQtAz5CunDXqxX8D7tk3TWthvV7jemB5hWZfpyZsFszvPYb59VFnyh6LFnGx6Ann/uUCBZORIa86GpNgkaSOtw10qqPgaUYPn18723hyzs3VvBZOmfBD1go9PllE5wnphOwJ0HSJHLh8AD6TpuCM+meIQhgu3czo1qww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aea379b1-aa1d-4392-78ac-08d8543e90a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 21:31:36.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lGfZmkGnEiAOCK7zAgdxWO4hAd598LaxVqNx2FuGFWlIspYcpjPDpOQ9z0m74QzyTNEv4ka79Tx/7jn8T3Thw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0183
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, September 8, 2020 2:16 PM
> > @@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	pbus =3D pdev->bus;
> >  	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata=
);
> >
> > +	if (hbus->state =3D=3D hv_pcibus_removing) {
> > +		/*
> > +		 * During hibernatin, when a CPU is offlined, the kernel tries
>=20
> s/hiberatin/hibernation/
Thanks! I'll post a v2 shortly with this typo fixed, and with Jake's Review=
ed-by.

Thanks,
-- Dexuan
