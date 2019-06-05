Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C441E363A2
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFESyt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 14:54:49 -0400
Received: from mail-eopbgr760124.outbound.protection.outlook.com ([40.107.76.124]:46350
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfFESyt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 14:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=q1kp6Odqf4WVeJf1RomDL72i2MRWybpu78y4/mPSVpdAdBsfJfHBZD4a158gpIw1aFVTbVJUEbrtxlHGu1+rrh377pH0XzzV1YV/QBpFWx+OvOk9v7yksb+eMCsRe27kcHq6fQkH2ZaqBhg3X07FiOzEkLbvyWnkWSBNI6fyAvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaDlE5VkNKMmJx8/Tnih8vx8pXGBxBacPntweXyt3uE=;
 b=RoR/oMCxTdtJWlf6KN+mTaMsWgRBEK9AewjPePYKLr5aBW5nqKtmouFF7SSebjaLmGKW6jdvkUdKQw0WXGhWk2lvWkOpsj0KWtPsALpYZ36eJzhV/8x5k5ttk1daJlZ7Q/gctpvtNErbVzxOnzGDTY1wImu0pOxzJTuPxpLMpcY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaDlE5VkNKMmJx8/Tnih8vx8pXGBxBacPntweXyt3uE=;
 b=kfGCgGLqgMDQJRn12Euc2cjbIfH29300LiII7haOP68QYtJWF8dKQfLpx64nynz+zF48mg77MXT4EVY1LZYELwiwW9EX+tH0yaNicxgGEkxeQbi77JbnQzoLMeiUdKnBONeNeHEq9KCTzhF9Y4Z83lmdjv5iQPAbKeIP4rt/UK8=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (2603:10b6:5:175::16)
 by DM6PR21MB1179.namprd21.prod.outlook.com (2603:10b6:5:161::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.3; Wed, 5 Jun
 2019 18:54:47 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::942:899a:9cfa:ef99]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::942:899a:9cfa:ef99%5]) with mapi id 15.20.1987.003; Wed, 5 Jun 2019
 18:54:47 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH] revert async probing of VMBus scsi device
Thread-Topic: [PATCH] revert async probing of VMBus scsi device
Thread-Index: AQHVG8/IR7QpHmHKgkqkBmLvagarZ6aNaI6Q
Date:   Wed, 5 Jun 2019 18:54:47 +0000
Message-ID: <DM6PR21MB1337FE76C5C33754ED9A561CCA160@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
In-Reply-To: <20190605185205.12583-1-sthemmin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-05T18:54:46.3704184Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9cdeae3a-6023-4375-9e1a-2472ae2d0f81;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03a1e78b-f476-4a9e-9b37-08d6e9e74823
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1179;
x-ms-traffictypediagnostic: DM6PR21MB1179:
x-microsoft-antispam-prvs: <DM6PR21MB1179D223AB91FB5F4398F873CA160@DM6PR21MB1179.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(39860400002)(346002)(13464003)(199004)(189003)(8936002)(476003)(229853002)(2906002)(76176011)(71200400001)(68736007)(4326008)(53546011)(2501003)(186003)(7736002)(55016002)(478600001)(14454004)(99286004)(74316002)(7696005)(52396003)(6436002)(256004)(3846002)(316002)(86362001)(6116002)(22452003)(4744005)(6506007)(6246003)(33656002)(10290500003)(76116006)(107886003)(81166006)(73956011)(486006)(305945005)(66946007)(71190400001)(52536014)(25786009)(66476007)(66446008)(53936002)(11346002)(8676002)(64756008)(66066001)(110136005)(66556008)(446003)(26005)(81156014)(8990500004)(54906003)(5660300002)(102836004)(10090500001)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1179;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: byCBRzuRILtH5RN+F8tX3hRZdWbYrnUXPyE7F0VZFJAm7KSEf5CXr7ySTxhrItvV85dyILL7tqeAoeQDWdEcfiENBr2ZK75n1vSeZqH99nDHcp1/Y7kM3oCub1+vBfACkmZ+70uHtQUlgD+2gHNdQDV4G3HtmGxOlLYOvq+iySSkFl6iL2Az7N8ksAi8beztrF6syCbj/C+g0uTI2BcSJBZrESBtqWnBvEFGhwJY0/vWtb8Vcsgv10Gwmzdq1CcfLPLXTHi7RpgdZCWMQGqBXe5jxOaU6vsOi3b0WWqZtZSmmqPOJUJ1W8geRWmIOLXIQVazt5KuFfx+4VjaxRDCGB4zqvzS6vbIIYbwpifVllnDaCkdQi3nSzSxezKQUuTmhWxr0BAgk6uzxs4My1KbdOop0m8eDv3B0l4IddTVGbs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a1e78b-f476-4a9e-9b37-08d6e9e74823
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 18:54:47.5363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haiyangz@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1179
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: linux-hyperv-owner@vger.kernel.org <linux-hyperv-
> owner@vger.kernel.org> On Behalf Of Stephen Hemminger
> Sent: Wednesday, June 5, 2019 2:52 PM
> To: linux-scsi@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org; Stephen Hemminger
> <sthemmin@microsoft.com>
> Subject: [PATCH] revert async probing of VMBus scsi device
>=20
> Doing asynchronous probing can lead to reordered device names which is
> leads to failed mounts.
>=20
> Fixes: af0a5646cb8d ("use the new async probing feature for the hyperv
> drivers")
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> ---

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
