Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD4BFF82
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfI0HAv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 03:00:51 -0400
Received: from mail-eopbgr1310133.outbound.protection.outlook.com ([40.107.131.133]:19808
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfI0HAv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 03:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKGFKPJiasNtwjPE7YhvfPxTOMlBgzIpxfRHVd0YGjYjZSWM/Tok+itiv5pZAW7U55CQkBUNJIKTjpAdwHmfzQ3LCqc+/wms4pSIR8nwOsSP5kcBMB77k/I3A+TfCuzamGulFsWk7eXsh/pjuxB/uKd/qJkmJdU7fe2z34Fn+aiuL3+QFGuHE3pufxkpSr5V9PvdWwOVT4wRT6fVBheSptMltavJxF5H96Pts9M18SgqKKsVz4qE/3eFTeHGpXeNG8fKXrSlf1jwHRVceAo8ysgHyc3psJZ6i5gODEpV51yOGdbBiY3FBIGqcdPOmgy52dw6ZHWYE5OMPujcjBNBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DhD484/bq8eFpP2TIW/lPziiZcZbHY7GQVS3jdPd6g=;
 b=T96zNRsLIzXAOn2EkGztsMLWrc1B6noR7bmr1II3YnJzzcG648rjd8Dzl8eqx7YKs8GZfK4613e9PQdq1+0QxcS/6XSy9Kj5JenmD7uTw3Xf8KorORoINMyiKDLLxAhVhntOldbSCmJeZYZS2m7zZWv0IiDBvaVvkLNGSlc3pRJwxcc0nsJziXN0E9gdeawwX3ryffI82XGxEyLmR3dbxWlsuIMtL0B7nvmeC9rKIYJmhtL+KTDMeMD+gI+IZB7Y4y0LOxD3KL/TKIoCiUpt9dHRgJX5BpoA3X60fnARkwud8QhT9ubtD+KTmIZ8o2Qtwum5ckJpleJPrHch5o5NBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DhD484/bq8eFpP2TIW/lPziiZcZbHY7GQVS3jdPd6g=;
 b=N2TPPGC8+0P49nI4/peGlRmGwNCPMKAVarYtKgyNjYavZNotRhtvT5x3UlHICoQj4xVwtRp4qlJugCaJYOtvBdquJpL/754kihXpuZQ2sTT9i8Ds7e0IVTfyvC0BYL06xzsmCDDrSjcXlvGwSnkmeTSyqlzZng5Bm1bIeltxurk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.4; Fri, 27 Sep 2019 07:00:40 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Fri, 27 Sep 2019
 07:00:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 2/4] PCI: hv: Add the support of hibernation
Thread-Topic: [PATCH 2/4] PCI: hv: Add the support of hibernation
Thread-Index: AQHVdIfH3fC8IaTlNE+UKx6f51EquKc/Fv0w
Date:   Fri, 27 Sep 2019 07:00:39 +0000
Message-ID: <PU1P153MB0169D7BA6134460B354DFCF0BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
 <1568245086-70601-3-git-send-email-decui@microsoft.com>
 <20190926163049.GB7827@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190926163049.GB7827@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-27T07:00:38.3231724Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=544c566a-4e95-4f56-9c99-b9b33894ad3a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:557a:f14b:ea25:465f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61204121-1258-4e55-3583-08d743186834
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0155:|PU1P153MB0155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01552FAE5A68E59F327ACDB8BF810@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(476003)(86362001)(25786009)(2906002)(6246003)(107886003)(4326008)(229853002)(55016002)(9686003)(10290500003)(6436002)(6916009)(478600001)(6116002)(46003)(74316002)(8990500004)(99286004)(7736002)(4744005)(305945005)(256004)(102836004)(10090500001)(76176011)(52536014)(7696005)(316002)(54906003)(186003)(6506007)(5660300002)(64756008)(66556008)(66476007)(66446008)(81156014)(76116006)(14454004)(81166006)(66946007)(8676002)(14444005)(8936002)(71190400001)(71200400001)(22452003)(486006)(446003)(33656002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKJY/DBXUAvqNCKrCM8ZInCUvYqxwViZliaJsoEZ9hKA1deL2mYp0gUbUu/ODoXwwNKF978+fqYGix2cYErPMmuo2V5RMPsSViEb+B26eLGKqrzfUThTXOrfCwPA2hySONmttTh3FIKDZe5yMXmnwgWD7GlkybD1xQduxOGZogGxMXS0+zdc74IFPxSJPT+i3fllo2ybii8bdB/zr64YgxA1CY8qzcUXfqIRyvME+/KvOEnAZoQE5exe/Da8SDuUAUr/N9liiAIOxXimiUh8RukE7Z8SgL05zz7azlKqVh4zdl+Nrb/BXzZc5F40VDFAOtiIUBVmigcI+/1L8hNsL82eV2bzAt755gUdYIT077ZVvvMKIZhfyGMSu8m4Gbuk1d1ez1VIzyv0EcY1h60txphkSMDX6aSbPKzuj4A7IQs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61204121-1258-4e55-3583-08d743186834
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:00:39.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1DfHP1e1ATkS31Ajj9vZp3LoP3B/neFOZR7P73PIb5IMcJiaDOEcppWyLYUcJa4immlI0cNSqWLxzR9leQdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, September 26, 2019 9:31 AM
>=20
> On Wed, Sep 11, 2019 at 11:38:20PM +0000, Dexuan Cui wrote:
> > Implement the suspend/resume callbacks for hibernation.
> >
> > hv_pci_suspend() needs to prevent any new work from being queued: a lat=
er
> > patch will address this issue.
>=20
> I don't see why you have two separate patches, the second one fixing the
> previous (this one). Squash them together and merge them as such, or
> there is something I am missing here.
>=20
> Lorenzo

I was trying to make it easier to review the changes by spliting the change=
s
into 2 smaller patches. :-)

I'll merge patch 2/4 and patch 3/4 into one patch, and post a v2.

Thanks,
-- Dexuan
