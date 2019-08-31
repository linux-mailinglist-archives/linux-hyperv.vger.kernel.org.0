Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1107A425A
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 07:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfHaFI3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 31 Aug 2019 01:08:29 -0400
Received: from mail-eopbgr1320110.outbound.protection.outlook.com ([40.107.132.110]:16743
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfHaFI3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 31 Aug 2019 01:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar7HXPES7MuOwleZbiqkMwxjZ2iA7S8D+UBYU5AIFEkpXGgTxo6nWfJqKBsDKn5C6f/33+bK4zKSLSQ5HGMMo9Yavx2buW1/OiuR6ElO0R809fGvlOMe5cBZ02nH6Lzq0ldXuSyh7TOvu9HymQjBU5R/mNmMb6RLGiq6g7nZTnPIUKKwVWCRxFSlQKhQxmWqIRMwgKH4IsyPELTSpE0Ay16zcAm18wNpm7cC0mN6TwN0P/OIX6eJgAv18w/WJxiDQzc1f6x89fcPuKq1o9Mh7mX0vAOB6fYc1iHpELcka9Dz5fya5GuQiUB+iSECUL9r24DmXOkyIzzjs+u8EtSSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA6X+W5zptJvN4HI8A2wCbBKTz5bhQ2HDE4wIt3FkeQ=;
 b=giglphmlXblA6FDn7kHegheaHLCvdScQqwaCkzrSurTlWwu6HLGSGPetZIVj3y6PBmZFOycv53z9toQnFBPwj2HdTlaq7lz/PkAMD/Z/+/JOQBJDfIjl3yTK22NajuokopzEEg1txQPrvs9HEDtYAOTuZeIUVz/67nKnJrd+NWTNpAqiUtXPn4tCF1228xpbO2FPinUWAjGzkspGMYGj7FxMWQIE6lMZdEbLHRh9xunB8yJ0AsiLWhUXu5hvGauMBZYa2SR+7zdeYX6z6E/QUfDjQnpcfEKr8FXMmaZD3TbELX5bQt9fsfryb91H1cCRjIgvLEIC1jSbFcY0tNntzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA6X+W5zptJvN4HI8A2wCbBKTz5bhQ2HDE4wIt3FkeQ=;
 b=blREolhwIWBI2zdghEV0lZmAS8YAlPoPaYd5LYWgMuewhKHTk5cch3OYVOkq4Xgnm17ewU0zNabEG5xlLs2fNNwhewcrusHHJ7+CfO11CKLNSU8GJWj+LjTakSMFgWfYLUgr2llclFTqGbhEgTUJLUgrGwtjjYHD9yBSfKTQcGs=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Sat, 31 Aug 2019 05:08:22 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.006; Sat, 31 Aug 2019
 05:08:22 +0000
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
Subject: RE: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Topic: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVVvnhnZYV8iEJF0ORPS4BQ7lYm6cJMgUQgAty55CAACBSgA==
Date:   Sat, 31 Aug 2019 05:08:21 +0000
Message-ID: <PU1P153MB0169999AD4830D9347C0990CBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-13-git-send-email-decui@microsoft.com>
 <DM5PR21MB01370691E881D59773B9EF60D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
 <PU1P153MB0169E3DD602FB575C346186DBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169E3DD602FB575C346186DBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:25:01.1543000Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ed8325f3-7994-47a0-9ecc-2c1fc987ecca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:5cbd:8ecd:62e5:20b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f998777a-aa3a-48b8-a36a-08d72dd13ec7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0121;
x-ms-traffictypediagnostic: PU1P153MB0121:|PU1P153MB0121:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0121B88EE44BBFF731E50BA5BFBC0@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(229853002)(25786009)(66946007)(66476007)(66556008)(64756008)(66446008)(14454004)(2501003)(76116006)(6116002)(478600001)(8936002)(10290500003)(2940100002)(71200400001)(71190400001)(10090500001)(2906002)(5660300002)(99286004)(186003)(52536014)(46003)(7696005)(6506007)(102836004)(76176011)(1511001)(486006)(446003)(476003)(11346002)(8990500004)(33656002)(316002)(22452003)(7736002)(6246003)(110136005)(55016002)(53936002)(81156014)(6436002)(4326008)(8676002)(9686003)(74316002)(305945005)(2201001)(86362001)(256004)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sy1OdOUcBrG6XWuuMBcBfnlE0gSOuUhFYgwkFiSpfWkN6gpsibDmTG26vhuEqu9NzjmaWdIBeMwGjDTb8cYPN2YkBdsw3V53p2CfSLYtJudBcOSDaypYxsEXf4iZpbLKuUlGVQs+wUm+LAKV32SjuyWz/ZbNFZhdMZ3NQb0MIGOyNrwwH2fOF9/HbOypFils3Hxgfo3O7BD04x8AXsw4w2NX/Y8tZ4AKYXXC9u0YBytaNTuq362OnmTDe2ChnVTitgN83kp6dz7fowWYVlr2v5PMScmhurHuStBxWSn6RRa4HDPxgeoALfBN9XaAk85Y+V/w9ZsmQIkWvMuGcRrKvAvZhnnogAEG69j5yljwVMI7NO77XgmAqV8zDxo8+vy4onigr2ML2kL+V+LZm4PZp+YrySSnP+WYGcD7Cil1mDs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f998777a-aa3a-48b8-a36a-08d72dd13ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 05:08:21.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aozCWwohlsY++CCkURIEZF6q2oXPiqvv34+d4WB+UKcs0/hvhwEIcz2m9RoDOhfoCKrY+9WVwpqqppGMYaIYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui
> Sent: Friday, August 30, 2019 9:37 PM
> > Is the intent to proceed and use the new offer?
> Yes, since this is not an error.
>=20
> I'll add a comment before the "Mismatched offer from the host" for this.

Hi Michael,=20
I'm going to make the below change in v4.

--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -956,7 +956,13 @@ static void vmbus_onoffer(struct vmbus_channel_message=
_header *hdr)
                        return;
                }

-               pr_debug("Mismatched offer from the host (relid=3D%d)\n",
+               /*
+                * This is not an error, since the host can also change the
+                * other field(s) of the offer, e.g. on WS RS5 (Build 17763=
),
+                * the offer->connection_id of the Mellanox VF vmbus device
+                * can change when the host reoffers the device upon resume=
.
+                */
+               pr_debug("vmbus offer changed: relid=3D%d\n",
                         offer->child_relid);

                print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSE=
T,
@@ -965,6 +971,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_=
header *hdr)
                print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSE=
T,
                                     16, 4, offer, offer_sz, false);

+               /* Fix up the old channel. */
                vmbus_setup_channel_state(oldchannel, offer);

                check_ready_for_resume_event();
Thanks,
-- Dexuan
