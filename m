Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9973C624BA2
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Nov 2022 21:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKJUTt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Nov 2022 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiKJUTb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Nov 2022 15:19:31 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11020021.outbound.protection.outlook.com [40.93.198.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01185D67
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Nov 2022 12:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoebVMxE1cIF1RBOk/g7qlROssg+tfh4HRJsGlcCJv+zurU1bAbb5OdJe85/wpBxGrUkBzyUBdJEktgsCfnNxPEveFJs+VdYdtTDgCHzwsKqz6eRQh580oFi0LSPd0pjqsF1XjJAxF+n2VgX2T+eZ0Mw2T4irezROqboggDJBPMIhRqpG8MUhu2OsPr9xMUzuv5KvDRHOQ/K/2pgJJEV1LNhAt+MMiIeoS0fmqFv3nzkELF9He4CuJExgPB9p2kvqefebkiUVPmlw55WR9ekUcz31K4f4VAGmsZwrijzNZMchjzDgPTPCrjwGVPyISthm+9mu8ZOCii+X6LIPV4VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56+FyGsqcqNrlnEsCxE6+zeJFeiID161ZgTWVkxofQo=;
 b=BNTxPy6XXhGOJ47h0dx/Wn0Udqf89e0NK0XGFV+gcMBnxi5EuEFqW5xDBv8crmZ11B7PigWpkZ5g0nQcH4QGJZkNnI9rUD4wa1ehQYm6yt6jv2anFx9fHm8WxNlR3Qn2J+veGLJD+nO8d/sndSUl6idvmkr2D96N6qXZRr2qBod+uAg+I/dhZVXH0HMy0nEke4j2IU7k4VNVWCJQOMFkJdMrIGsybx2S7KHFqdwSe7rR8IOkeWuGHjronZVbMla08/iX7d/GLuL5xJtgVNcdBCvRn+JDW7kAZC3tZd6NtGLkJ/75PgXzHTVvy7hi6zMzKkTj9ArNuiMDdVR18IGpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56+FyGsqcqNrlnEsCxE6+zeJFeiID161ZgTWVkxofQo=;
 b=We/ZVgmpUtf/qgpXO8maSORm7Rn1b7OEeg1ZcUB2b+b/vYO64MCsVJ8PzQhfzoUNgHmuY6ng4XGHqMRgmjBBGIc6YA+lanGxHSEeDbHNAYUVK3EdeaFK4UvIHzKVvn1VrQRSSj330lhbVLOPTm6CK7WZi3hbhH+clxn3bEwHFnI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by LV2PR21MB3327.namprd21.prod.outlook.com (2603:10b6:408:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Thu, 10 Nov
 2022 20:19:02 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5834.002; Thu, 10 Nov 2022
 20:19:02 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: fix double free in the error path
 of vmbus_add_channel_work()
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: fix double free in the error
 path of vmbus_add_channel_work()
Thread-Index: AQHY9NG8iFHx813wF0WnajzuRmQOy644mMLw
Date:   Thu, 10 Nov 2022 20:19:02 +0000
Message-ID: <SA1PR21MB133598A5B70F2535E9E7EDA1BF019@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221110065609.1848112-1-yangyingliang@huawei.com>
 <20221110065609.1848112-2-yangyingliang@huawei.com>
In-Reply-To: <20221110065609.1848112-2-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b2f98d42-3a49-46bc-9b06-05d0bd6e2727;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-10T20:15:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|LV2PR21MB3327:EE_
x-ms-office365-filtering-correlation-id: 98ab95bd-3d9b-472a-9ed2-08dac358cedf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: td2px21kL61EeEaM/nRhhKqGxRnIf8fLKsvhZtH+gnOS4SvPI2YkHcsFXYjovRS5vPJC3LcRuhQKje/FF2HxZ1HXpJc6QwbLMa/6lqYFjPx55IH0zXfzDxaI/NusO8j+KTgiC4udsofRDzyfaTcamIPRZ/0T0pF5KOUSK23fUIUunJt129OGhR0vCA0FEeFnI8ZjwFC7sqZb5x3CofyPXD8OW11j6ENPpe2zkcqzAQ+0ACrQN2iv/CAgPbTz4Kmx0rDqPI9PGJZyyEvnP4afS7YZ/gLZdUZOxY23vayLGon8jgZPE0BbwIjRcbsJ5mWz9n0fv7HgUguvhEHM+9BHmojtKMNL8K/9HvWApjQuywOJl6MVykIlzgrHynXGLKHU36JTbOLHJ50l6sPFG99aIRdSTgFYIwdtSi/wC/872xDGLL5TSZ1bQSoprJxH67xeDZ2X9JleblnhzhMUs17LnTtG+Vzhms+uKA77o5CerN/nVzR1LjFniZ+0e4x4DtANRmHf6vSvBMfOjrei+g5/3tUBoGwRTO/l3bep88AECtqoEtjb0hrmaD6S0e5Lyu7/cK9em9rc7xtDeWsek413oA74wsIkAyOfuDmeO0AsC1DsqD2WLqMyAtacOkV46646pGpMjrXVxoYf7j+d6cHweQuJi3xh4spSdGyEelLzut5SKRX8dYxVXDBCRf/BlgD2B5Euiv7SGF23haGiaZ5rHSo4IGSxtC1OhUA4VkHMuSydxUGgy4AQvFwbNQ1W0508J0jnUaqpRMyPhK2X5gAtTIA61TsMMwAkzTRQOlYKLY9mJBXcRlDygPobJn/JZDWL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(122000001)(5660300002)(38100700002)(82960400001)(4744005)(33656002)(82950400001)(38070700005)(86362001)(478600001)(110136005)(55016003)(41300700001)(8936002)(4326008)(64756008)(66946007)(71200400001)(66446008)(8676002)(66556008)(316002)(66476007)(76116006)(54906003)(8990500004)(2906002)(186003)(52536014)(10290500003)(26005)(9686003)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+6WEZsgfJJPBocsD1+rl+jyck0gbnCgEH59dhxrpjWDNXTFLmQqFF6aGSzN8?=
 =?us-ascii?Q?LJ1YXMjj3JbsdIrmcetVABt9QyxM2igoQQz4aWaXpSgaxqmsDArxElz2V2RZ?=
 =?us-ascii?Q?ubQC0bHol2WbWREmqsfirqR30G9mHS7ho0BnPQPkmUhxlqR/EXrUgusbY3J3?=
 =?us-ascii?Q?Il3e1uAJg8YOOV3jupwMk448xSMoaVY2L+oDr5oNsQOjO6OX1NKc8Pxej8ZP?=
 =?us-ascii?Q?oPW0193jUAuF0UVmEWrLpsJFoe9aQHhV5gwJjYocubW36BVg2k/ViIIQajCs?=
 =?us-ascii?Q?xU5PHSV1LnF6gjAhTWkuBmtFjD5p1uI3SfMAK/sKOtDZ6fOidqifb+mPj+3C?=
 =?us-ascii?Q?i58lXiZKLoDESgOVjw0EI41yPF2EeRhQtyzVJ27eiNHuTrIU/NoroVA9AqMx?=
 =?us-ascii?Q?S89FfQ/E4aP1LO/qTh6uFb9RY5Zetq+VEaUs+zp6BXH8T4L1PQxnM4I3oeRS?=
 =?us-ascii?Q?G8vT/sm0ZnboMdkb7CKTKMOS1WZOANYeF6ugXWPsBJmdnTkdl8OSgXHuN4rx?=
 =?us-ascii?Q?r91b0WbM8WK2dFlTHrzOZXk0fKc5/zU5y/yyfT7RnTHVHxaRCX3tl4j66TGB?=
 =?us-ascii?Q?dMmwW/KOgqhnmMkulP3ItNxoIgIRo+IuATdjZosF7DFzNSzDTzVCaCmGdypl?=
 =?us-ascii?Q?L2tpBgfk3EL1Zo5CnxoMZo/toj/7FZNDJY8OdR/F2giYvtuLtQcCI7icwOeN?=
 =?us-ascii?Q?WmyoNVqDdY5ZGe88BWoFyDLGeoPQlSiwx4yVAab/kEdp3MFOg2fb3/RHMbyX?=
 =?us-ascii?Q?PUhVF1RCMd0XfLNN3ifnwrg4XT1ykJIgkOKQk8x8bxopibL8fYKIhFytZPp1?=
 =?us-ascii?Q?mqcsVI2dRZqSA+HZruxwfk0g1M8+0WfGScnaaxYQUithaMihvcf2o6vSIBFw?=
 =?us-ascii?Q?UsbUCdCx+ZgndgFk5E8Zuoq6EfEyNaOaOTlv6Kyeqj875kUL7OWn394gOOv7?=
 =?us-ascii?Q?258CmIfXlQmwUJJtLbbocNQB6Ac8r4tZGhhO4+GHtpjcQSebiDCkGZf+vB2+?=
 =?us-ascii?Q?gJgBcF25x/cz6FkW3rLnot36bLY1PIcQOWOMTvk2ADkqB4FtGV6aJ8yJ4Sv1?=
 =?us-ascii?Q?qS0PUrIr7qPiBibx/GtRbYeU97nLIDwx8tJUDU6iAkn1rXx9ZMj6yMOzk0mw?=
 =?us-ascii?Q?NGZuz/sqiB2Fd+uxbwwFzlP2pMlomCBV9qHas9fYC9Omn7kMOJgLtzVHhetT?=
 =?us-ascii?Q?17HU38N76nEj16vbI0ZcmQB9z6rHKlitiuDJ+p34EYEbvRadWgh1yV/aUQds?=
 =?us-ascii?Q?5Kdo6XUOm4vyAZBy6FpK+pnN2G14y91+cmucGRWOOJntYKABc3GDyZ0RRhvQ?=
 =?us-ascii?Q?4jv/QIczJJDEXiEG4Cp+5box/B+9seNJM1EjFyRvFkewWd+mt7oVdI0UH1Rt?=
 =?us-ascii?Q?+mi8GAw80o8YEuJbxB21pZ+fzojL3jK4915luRKsTm5GUf9jHJWLBnUQboUq?=
 =?us-ascii?Q?OBb1IiLvagJdE5sH2fyEsvVnk2A/tYSqY/IqiuHtugVLpjOWXKVyiLXOEFBA?=
 =?us-ascii?Q?cDzYqX7h/a1luQnVtrjNqjzaNxJQ+H0tL1Mlz1Gg6ptQ3UvJ7Z+t+5hrH7q7?=
 =?us-ascii?Q?VsqUGMqSF1D/AemXzWsw9XNGE8iD164TNtvPX9UR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ab95bd-3d9b-472a-9ed2-08dac358cedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 20:19:02.1021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqjpKCoIb/pm6cLyuMrTvbZAebWw/7nfAc3bTZGMZNTY5ffkjVMUe0Sy+4kS/0GPkoNLcOj6bj/GffjwLSF6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Wednesday, November 9, 2022 10:56 PM
> ...
> In the error path of vmbus_device_register(), device_unregister() is
> called, hv_device has already been freed in vmbus_device_release(),
> remove the kfree() in vmbus_add_channel_work() to avoid double free.

This is not obvious. Can you please add a comment for this before the
invokcation of vmbus_device_register() in vmbus_add_channel_work()?


