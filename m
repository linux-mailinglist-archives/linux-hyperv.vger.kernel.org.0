Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E659E7B629
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfG3XSb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 19:18:31 -0400
Received: from mail-eopbgr1310105.outbound.protection.outlook.com ([40.107.131.105]:63600
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfG3XSb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 19:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqbDiYLivybAs7WkwcIN9owEVrWVT4AdM7X6tchCR+MOjflRzmmpGneO69WIrFCzKnFcDfS+pgETwM5uvXwkNrgDJxQBUw65mHMkjoMYlvyUg37gSFqv21fqB2NFnB1PtheSlFd0fiQh5V/t48DozC3ejddLKzWVBrML1BleVHi9OLMpUsIq6fGIFnr5wPLu/q4pEEbknvo/fqvu++LEopMrlrlwSxUJPaC3u6rRicNyi27/AsZx0Rw1BaDssycxoIQzLUkFs29nwjJMRf1Ce9Iyug6DbwsbloFszBeNVxHXPEBqTOQe5U9AJEO8eNuV52vB8ghiLcsa2ASSMkoq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzlxTLQ192LB1nVJkVzqRM9BkT0NI55I6dlftzw6gAI=;
 b=K/0NDN9VJRb/hcEosb1mRaVATkxo2XCb0a19+YTONF3+ZjrcGQKYl+Sk5bZuntYOHlRgXkRidyZLT91UquLCMnenTk5JzX+PXE8QVs+JUgVtV7I2k7ObqzmNun2twRdFkVsDZp8J9pmJZF0yCPMRw7Y05NrT258I0+5V4++mzR1e8bxyVKmN/o3Vmalp4xU2/d8kwJKHp87K4cPpiP58irGZQTJsda3OV8OjV+v/sUEz+Beg5Ei3bMGkvVlNWY6gJWLusjExP7ACDg5ol7oXeVe7ErxEyMoKD5f1xAr5CI6pVXZKXxW8QHxAqF9mIkxj5IiNDo0lnH3ha29Ju5Iw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzlxTLQ192LB1nVJkVzqRM9BkT0NI55I6dlftzw6gAI=;
 b=n4ZltgIfac157QCQ5fJQLYKxEAF2OC6INdYETMDx+tAx4LsiFT82GQ8K6tgoBiLCP2eV38SE/67v00+TgABxDpqjQHQisDx99tj2+ZIv+G6GNEcxCH88Mt6bMmcKDLhLYE11+uylnHEAVifomtNVrlGIBTF+tiTfDfVryalE8Ls=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0106.APCP153.PROD.OUTLOOK.COM (10.170.188.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 23:18:21 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%8]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 23:18:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] Drivers: hv: vmbus: Split hv_synic_init/cleanup into
 regs and timer settings
Thread-Topic: [PATCH 3/7] Drivers: hv: vmbus: Split hv_synic_init/cleanup into
 regs and timer settings
Thread-Index: AQHVNhdHF9iN5SffUkeN3ldh24O58qbj4FjggAAMssA=
Date:   Tue, 30 Jul 2019 23:18:20 +0000
Message-ID: <PU1P153MB01691455A8C8FB6751887C48BFDC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-4-git-send-email-decui@microsoft.com>
 <MWHPR21MB0784D7CFED4961C5B3D310B4D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0784D7CFED4961C5B3D310B4D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T22:35:30.8830380Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b0c3192f-cc83-4b10-908c-c226dbf4abcf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:c0f7:3271:ccd8:4d01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6a00748-d624-481f-5dad-08d715443681
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0106;
x-ms-traffictypediagnostic: PU1P153MB0106:|PU1P153MB0106:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0106E87D6C3E611C84A71BA1BFDC0@PU1P153MB0106.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(396003)(376002)(346002)(136003)(54534003)(199004)(189003)(66476007)(6246003)(66946007)(305945005)(81166006)(8936002)(71200400001)(110136005)(256004)(2906002)(74316002)(4326008)(10090500001)(8676002)(8990500004)(25786009)(316002)(99286004)(22452003)(2201001)(68736007)(7736002)(1511001)(81156014)(86362001)(53936002)(71190400001)(6116002)(55016002)(186003)(9686003)(7696005)(10290500003)(486006)(446003)(46003)(76176011)(102836004)(478600001)(52536014)(11346002)(476003)(33656002)(14454004)(229853002)(2501003)(6506007)(66446008)(66556008)(76116006)(64756008)(5660300002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0106;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +mS0X/gpQiZPT+Xd7TuUqWmyxP7ML7EZYlwAdhq9hRcDiWXE8V2EVtf3rM56pUKZvHcgzmbYoD1IYtGG798NQv1bVZnyZeGHBc5wSKlqSQD2L3C4+a/PrB3uDmL9HMbYsrb7FlTddtH4GMNPtk/MvC6bE+OZ4bQNL3yB/esFfrCjMmOBHO+6G8bSfObkPWFEVcXZuHQv/Ir4QyXzrJdtHULdxhyz2DZxM8xQGoG1KVxxdNrhkjm7ZUEnAVnIQutHhJjVZyZ/7V7suieb3lE0abmBkQCnO4qq+hxyW+ishJqo8/iHpzixUwmBgjIsU3EkdIDYAjvg6Yb0mnvX5OhlBavksgoFOk2Bk1vnsgHEQtdI4fj/Vgl36OdzEvEeq25imy5xy7HfbREn13/W2a3nWT3Bb2yH80QnvXXBfTrJW8Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a00748-d624-481f-5dad-08d715443681
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 23:18:20.8594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OLn3oTwRO9JuZv623uxN+p46+ayvyq97VN0qg7Z7XD96v8YPKxcj8FhlKr5OKhCmq0emk80XlKYupLDuaN2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0106
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, July 30, 2019 3:36 PM
>=20
> From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, July 8, 2019 10:29
> PM
> >
> > There is only one functional change: the unnecessary check
> > "if (sctrl.enable !=3D 1) return -EFAULT;" is removed, because when we'=
re in
> > hv_synic_cleanup(), we're absolutely sure sctrl.enable must be 1.
> >
> > The new functions hv_synic_disable/enable_regs() will be used by a late=
r
> patch
> > to support hibernation.
>=20
> Seems like this commit message doesn't really describe the main change.
> How about:
>=20
> Break out synic enable and disable operations into separate
> hv_synic_disable_regs() and hv_synic_enable_regs() functions for use by a
> later patch to support hibernation.
>=20
> There is no functional change except the unnecessary check
> "if (sctrl.enable !=3D 1) return -EFAULT;" is removed, because when we're=
 in
> hv_synic_cleanup(), we're absolutely sure sctrl.enable must be 1.
>=20
> Otherwise,
>=20
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Thanks! I'll use your version as the changelog of v2. I'll change the=20
Subject accordingly.

Thanks,
-- Dexuan
