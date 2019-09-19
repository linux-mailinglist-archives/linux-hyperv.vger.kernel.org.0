Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83C3B7285
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 07:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfISFPJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 01:15:09 -0400
Received: from mail-eopbgr1320112.outbound.protection.outlook.com ([40.107.132.112]:24598
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387579AbfISFPI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 01:15:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8aN945kJYl34OLRhtO4WRdlqQvko7AJDUHpPwCr6+OHH8U67StY+ingEVjWaSdqdgf9DoD2epYTTwRnyOSZq8vPe3NQIryZO31kx+0BwaqBndnuOEoLDm6o4+z93HKW82gs8foTOqGBZ7tb8uYinkE6onrnBtEw8RO0Oq/+B85Sai/7CLEOjLqH5BQ5X7ztMG6ygvM/xIaEEQMNSeVqH6kJU6rmDaCLo8Es4mOoYnZ6swBLsIa4kKJQ58sTiMfRhJxtHEOuIBf1qiD7/vBSyhlFQDaT4pHbU/RxuiYMXCRmtTiBOSXfTFjSTdher7kCkENmE8lq0nEdJsn9Kv8g8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rjKAngAEIrNzN+y7SJu4QFbpmMu7LHEMoLoLdV81bE=;
 b=Q25GBe4raFWAzaFd27sut9bPOzqzVNrZDoexBY0xtPnxVixfCv/sOo6FTEUv9QkfIN9Zt75KO3ooFxFZGJmCoaVMFvm1HDXLZaLMo1IH8YTyTsV6MRBOMFztx4C9wkPQA28Qd64r+Bl+KEHQ5lQM+CYHFlAngYCWtHHHxLrJyW811uUxTCWzpDNKChnpRsMwgRKctn5QZufKhLUSV+3Pd6gmyEz2/yym9m/XM628A7wPAXLfQ5nl6kRjisx9Z0t5qESv9jn32Us1w/SzpgayazSPjetXc8ATdsi8P24NFS6hD2u6t/QzBTyBopf/3PLGHeZJx1rmRT/3HFIGSvbqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rjKAngAEIrNzN+y7SJu4QFbpmMu7LHEMoLoLdV81bE=;
 b=gAiYg2zIDPq5fFLYhpEAqpsvrHmgSaFu7D6mL7WfLLdhtNmLWhb24LUf1zbPh5E092NO9R0UJqMzmPQZkH1fVAv6PX71WuBuZj2nRowjPT6OBtW573TIbJ6+lWHYUpDwW8vKXZ0GtJijXWls9ojBf195G9zqb23g999dUU5cUTQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Thu, 19 Sep 2019 05:15:03 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.000; Thu, 19 Sep 2019
 05:15:03 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: vmbus: mark PM functions as __maybe_unused
Thread-Topic: [PATCH] hv: vmbus: mark PM functions as __maybe_unused
Thread-Index: AQHVblvNo7VNLrxiR0GbRPiaLz1gQ6cydNCQ
Date:   Thu, 19 Sep 2019 05:15:03 +0000
Message-ID: <PU1P153MB0169B746C28A10A941E48F0ABF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190918200052.2261769-1-arnd@arndb.de>
In-Reply-To: <20190918200052.2261769-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-19T05:15:00.7754668Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b3f8caf-05ee-4aee-8a57-cc033cb9f59e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:9da0:245f:bd15:5f6a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ecb658f-307d-4b89-b363-08d73cc053d9
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0201B837A76EAA9364C42A81BF890@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(64756008)(186003)(54906003)(66446008)(33656002)(66556008)(66946007)(66476007)(6506007)(8936002)(22452003)(8676002)(11346002)(7696005)(76116006)(76176011)(316002)(9686003)(6246003)(476003)(6436002)(486006)(81166006)(81156014)(52536014)(46003)(102836004)(305945005)(7736002)(446003)(74316002)(5660300002)(86362001)(256004)(4744005)(229853002)(99286004)(110136005)(14444005)(14454004)(55016002)(71190400001)(71200400001)(8990500004)(478600001)(1511001)(10090500001)(2906002)(25786009)(4326008)(10290500003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SiOZvGoM1wt6C59ELzNKcAkZfAO7eHXnSMgwQnqQ8HEZprwKABu2Re3fSGItlnxksokpnZerouvqPEGgEfrs5zVlBGALyJkIwvgSiaivHrSvXitNC1pPMzbpnqJs7usCavuunCeVLMCsRLBzIbUNkGb4clNjlmNlzdQ5V4KMnU/zfIkSdQBGtL4AvzFYRLxlGejuZ/T94LEUj0sQjT/8/U3Orrl4ShaD+fvhqjNH+U2Wa6PguJX70NKSSx41xWpCxXnyy8Dvltr6NrO9Jg7QC2rv9+FBkUKZMJ/HATxE3405dp1ZGVjiXOIavMzE4nLBi5qTCAwtJ+58G3QAJNPccAooQMddUsqThGyKwvzu0kJw8YwFsVEsLP47K9wUyGAsJ0R076tHpCo8RA8527TYUsUiz+ztz+QWDObvokeVwY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecb658f-307d-4b89-b363-08d73cc053d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 05:15:03.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGXvPeV0bZFBSH+qkE5Uhy30RUn17CV8onfyxrIysX3k6EpK/M1ZPZ+IGtLvU3zl3BNEqh6k2EM2T1qLAj6oCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, September 18, 2019 1:01 PM
>=20
> When CONFIG_PM is disabled, we get a couple of harmless warnings:
>=20
> drivers/hv/vmbus_drv.c:918:12: error: unused function 'vmbus_suspend'
> [-Werror,-Wunused-function]
> drivers/hv/vmbus_drv.c:937:12: error: unused function 'vmbus_resume'
> [-Werror,-Wunused-function]
> drivers/hv/vmbus_drv.c:2128:12: error: unused function 'vmbus_bus_suspend=
'
> [-Werror,-Wunused-function]
> drivers/hv/vmbus_drv.c:2208:12: error: unused function 'vmbus_bus_resume'
> [-Werror,-Wunused-function]
>=20
> Mark these functions __maybe_unused to let gcc drop them silently.

Hi Arnd,
Thanks for reporting the issue!

If CONFIG_PM is not set, IMO it's better to comment out these functions. :-=
)

I'll post a patch for this with you Cc'd.

Thanks,
-- Dexuan
