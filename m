Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84C9CEA8A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Oct 2019 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJGRZ3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Oct 2019 13:25:29 -0400
Received: from mail-eopbgr1310123.outbound.protection.outlook.com ([40.107.131.123]:30906
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfJGRZ3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Oct 2019 13:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2U+HRdYlQ4+OAY9DiO5uHfYJvGOSlkAF4mGBiTq9D3K4w1VwaHGUY/OZXJPCH8VprEFq/igCCzrImnLS3V0LuKG/inQNlNPdfwH8KwUe8pjlZ/8zu/RdJdEYJtYmozmdm/nR2QQen+5pu/i9ew2N56+4ho2ZTDXNntOAJbgCm1wQ60AtOj/F8jx4nmeTvos5/+QtjzcjUSC9UE9ZcfKBcKS5Ma1imYd9xyjclG1dtp3vJTV23ZUprHSSmRwjDtZLy4ji7Zear2mCnaNv6Ft9v9rYYFdGIdRhogsdN2FkbJmzGCTV9hjI6lFhC7Sexi45/MP463vwglX73hF8A55zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTN8DzsLNX+G4kiEDg9fHEgEyPKaABTSyatsaTuHZE4=;
 b=aNaW4LPKrAVM0ZHWLe6F9Pjudz0YMS42+Z0X1UFxA6/S01bO618dLUuFUc/TZ6Rlihhf+t39u9dSB8jfBKJB5ENTO/iSNxYdvojSx7nzupLTl9GE0/Sgkbfd7kcxR6E/x9Y5L76WS1nUFsknyAVOr5BRC3lcJvxHKN2Jru1kpeo9kVbO2sB11bwQi1QyMSTdfOyac8V2kU+uJUmCA7Mce/4dxGEhWdhOFDYAQk1Vk6HyjjhvFd7Yd9dYAM1vDOL3fwwCqZFNgFRo/R3/Ay+irOOdiHuOwG3CLyNR9S6dadMjtyUKpuGk+7/oXADhP52X+oxNhTGd1cpaAk0CrvQwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTN8DzsLNX+G4kiEDg9fHEgEyPKaABTSyatsaTuHZE4=;
 b=bqfkGMcRCH6gctW83xOj3ZiJju12ue09gdsCaHUNgGPSFa0a2VQNK6E4X2f/pat6NEn3GJYqTdrCyTkEzv8F7g/p/npHajgCe3vlCtlVbSmx8RjevKKCLXlnwZUi5RvI+Ocv9a36WBPZpGjZ1Kvqk5AAIf+t/veJnU/mVziHOgE=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0186.APCP153.PROD.OUTLOOK.COM (10.170.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.13; Mon, 7 Oct 2019 17:25:18 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2367.004; Mon, 7 Oct 2019
 17:25:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus protocol
 versions
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Thread-Index: AQHVfSzKc5KO2kE/XECN2J8gzpV8GKdPbL4g
Date:   Mon, 7 Oct 2019 17:25:18 +0000
Message-ID: <PU1P153MB0169CAC756996A623CFDFBA7BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <20191007163115.26197-2-parri.andrea@gmail.com>
In-Reply-To: <20191007163115.26197-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-07T17:25:14.8404437Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e9786b0-faad-44a9-a7cc-3c1339e88dfa;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:44a6:f3e:a757:ee91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3904b5f6-881d-44ce-b709-08d74b4b5326
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0186:|PU1P153MB0186:|PU1P153MB0186:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB018600E275C4014FA93EFEF3BF9B0@PU1P153MB0186.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(199004)(189003)(66946007)(86362001)(316002)(478600001)(76116006)(9686003)(486006)(22452003)(476003)(6436002)(2201001)(229853002)(64756008)(66476007)(66556008)(7736002)(76176011)(81156014)(81166006)(66446008)(25786009)(7696005)(52536014)(8676002)(99286004)(102836004)(33656002)(4744005)(4326008)(256004)(2501003)(8990500004)(5660300002)(6506007)(71200400001)(74316002)(71190400001)(46003)(446003)(6116002)(2906002)(305945005)(11346002)(14444005)(10290500003)(186003)(8936002)(6246003)(110136005)(55016002)(14454004)(10090500001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0186;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UO7Y/MAcNIhhXDZzqk9ZjGN9/c7I1UtxQ0SuVd8eavSfnNnCsUOFo5DExolmG3EJmha4rq2RrmCbY3Yfjq+dQR4UJ/QAnBoLp4+M0FZJm1x5xH4WdlWDm7ujb+xMkkshVLydpk05tyTGBlBGMZRIliI92X7pLSoIDKJLrVdciDg2mtcbUh2dN8H62myNcvv7peD/bbLdLRgnoCjC2OJj/xkhc9e5lewyKb8J9wb3TGGeQxXV/YOJp8OjBZGT2p891uEQSqE646aSaH2ShxZWg1TPD0/oFnYLuplBU+5Bhx7dbzKKluNRvjSIGYlGLIhjYhNRg4Bqn/jaU3984ZBYvLQHd59kjRmzwf6O/pMxKLi294c+9YuAbYnDbXPY0seMPrKMkexAz3RBSGcWURcz3eUYc+pyfqfTdYlaeyxX6HM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3904b5f6-881d-44ce-b709-08d74b4b5326
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 17:25:18.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3WdfaU6i4v194s1Qm3JOQ0uIQTMfvqASyxJ3d+y60iTzAYVf1gVpDIqAIaUFzdMg+1Fwek/Ki72HjM39h2rdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0186
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andrea Parri
> Sent: Monday, October 7, 2019 9:31 AM
> ....
> +/*
> + * Table of VMBus versions listed from newest to oldest; the table
> + * must terminate with VERSION_INVAL.
> + */
> +__u32 vmbus_versions[] =3D {
> +	VERSION_WIN10_V5,

This should be "static"?
=20
Thanks,
Dexuan
