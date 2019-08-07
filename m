Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1484FBD
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2019 17:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfHGPWv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Aug 2019 11:22:51 -0400
Received: from mail-eopbgr700101.outbound.protection.outlook.com ([40.107.70.101]:32608
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387888AbfHGPWv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Aug 2019 11:22:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iupS2U5soLEFlbyhMH78WxeFA+HYTQufVe/x5AGAFz6WZIUzd2MM4D9HLByz1T8bptFjxVlAJMYwvaEtndCEJRJB3h+s1aYyizh4E28NCmweme/D+sF9tbO6LcqjQXimyTTKPcTyV9bM1VXUK19Jt13s3J6AbjK+a6jJ7i61MbZyOHChmcro5PS6AhI5jChenPxX0bwhuSmJNiVOV73EqbgAlmorwGBu0nBwV7fgznJganDs7opdFmtqEealcDWnE2SAScZQTnsufCROovz0QIt/hWKnRgh3bydYhPuKMhbjgIaWBHnl7Uv6cXuQn+7SMwcaXi6iW6Vq01WTu39iIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuV6DRDizSqljjvmnndXwR5pC7GdSYky5wZDnwyPFFg=;
 b=fAfA/PH3ySkgMkcKierXrfMTghT5TjNiHZK5T0ce1rtSfhLjCg01fqeF8TpSxu2Pw8ozvzZYY+a3Tqtq4344cdLPhuUEIhTa892YxFKzaUn0+N3xpmIy/8iTMWxK0S7eyCEtJOUskVCIiI/Si+2LQ+gN89GUm3qPnTmq0trqkwPKsAQFsdP67sqG9dns70wOok/tkywCp42EZBPycifih4B0OwuNm8EM1Q0BPEZVqYuV+Zc5Dojhgo8pfty+snwbk4pqvij87GT9c1OYMDpyQ6Wykfk63CwAl4gmYELZUTGZAaW6edMLF2jzsgJxYgMHcqt9BV8ePNhGo1qoPNUVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuV6DRDizSqljjvmnndXwR5pC7GdSYky5wZDnwyPFFg=;
 b=dsmscaT5ZcyA/D6FiZAA0LuaANafXUGwOOxRW9J9nOaKoEKOSdZ22ZOybSYJHWIONT9gfp5Vs9tZjRWEwdsWm4XhthZGnGA19mY0bE4B0djSm8Ysxjl1cEdYNj4DkqpZT8FxzSJqRkoKFyvfI7wQVL57O/Mt5CJgI+px8W5FHQI=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0748.namprd21.prod.outlook.com (10.173.172.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 7 Aug 2019 15:22:49 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd%2]) with mapi id 15.20.2157.011; Wed, 7 Aug 2019
 15:22:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Topic: [PATCH v2 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Index: AQHVR8iruWjeXMDDo0mhtEN+e0v9pabv2CsQ
Date:   Wed, 7 Aug 2019 15:22:49 +0000
Message-ID: <DM5PR21MB0137C778E75E6A90234C7B5AD7D40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
 <1564595464-56520-7-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-7-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-07T15:22:47.6530150Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a47a3cd-55d3-468a-805c-e721ef20de69;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:2e16:ac86:48d:60c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b82d04fc-53bc-46ae-a4d2-08d71b4b1b67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0748;
x-ms-traffictypediagnostic: DM5PR21MB0748:|DM5PR21MB0748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB074852814164D439EDB69F6DD7D40@DM5PR21MB0748.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(6506007)(66946007)(7696005)(186003)(229853002)(15650500001)(102836004)(76176011)(476003)(4326008)(86362001)(10090500001)(25786009)(10290500003)(6246003)(478600001)(446003)(2201001)(7736002)(22452003)(64756008)(6116002)(66446008)(110136005)(33656002)(46003)(8936002)(55016002)(74316002)(53936002)(4744005)(5660300002)(71190400001)(1511001)(68736007)(316002)(305945005)(9686003)(11346002)(76116006)(66476007)(14454004)(2501003)(66556008)(2906002)(71200400001)(486006)(256004)(81156014)(81166006)(8676002)(6436002)(99286004)(8990500004)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0748;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BaeohS9PwiR1fk58ArL00ncfgd+sd3SKW4SALjwzI+/1WT5hJKN962XeQ0rj6j7sNi6avx1RHbkcgGwzsF+GGlz/WUEEwbAvnaZwdKkCOwu77Il64XQRXrPlZAgsgK8TEX6SUIkW5nMuVQNJg0LfWsSsINTq9bNcI9KdBIRNEry1ynUBWt9b6VviVQITiYSDzcj48HcO+71OuoabSI4btF7ABp9zSpPmB2/EX/b0HC4SuQ09sg2Xtj6gqAnGhbpSFP1tM0cF6kFeJwth10bgm1RQhSgbLNr68Tawm2m2F14jPm8H+hWryX25ZIgRioc3QK/RNqlSEdGNqEQVD5EJfdiWCH97opwce189uMZsE21KGUOuGdBAWtg/Y7r3UdgoNGU7YzGgtw97W++hM8d1vXhMzQOrxMVUE5lI+CqJFLE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82d04fc-53bc-46ae-a4d2-08d71b4b1b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 15:22:49.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpaTaWASPnuaj9+BU5F2whEut5xdHvKcugnecJ/3oYCN5L/incxkT+hlT1TuNxIGP2wUdC++pbplE6yEzrRORJYcFdbAjYNepcXApC2K9BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, July 31, 2019 10:52=
 AM
>=20
> Before Linux enters hibernation, it sends the CHANNELMSG_UNLOAD message t=
o
> the host so all the offers are gone. After hibernation, Linux needs to
> re-negotiate with the host using the same vmbus protocol version (which
> was in use before hibernation), and ask the host to re-offer the vmbus
> devices.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/connection.c   |  3 +--
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  drivers/hv/vmbus_drv.c    | 50
> +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
