Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C85ABD12
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Sep 2022 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiICEiW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 3 Sep 2022 00:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiICEiU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 3 Sep 2022 00:38:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A847F8ED6;
        Fri,  2 Sep 2022 21:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCGKkNzmDsa3VtWTRKWBimlf93K8SNYX4V9MsdbudCxNf5ionz0BqMHrHflc85HdY8RO7ZHJRQFgPVgfTzK3IVQdMeO5egcIoC5W+uAsUMIAiKBmrvrQIydRQmQRxRWad7h5PIw276kcrf6bNjkjxNYgSzpQRmDPlkWuOSR6nVTehfaxF31VtrPDNfyZdfciV4nQtDBYAc/s9x1PsWEpZL9Cs/+W/R8lt8MKLrKM4h8RrLB5hgk6IFekoiMuVCe7p/JSsbzk9sRSE8pqPJP+ipeE2aBzlGGirPnfvP4tpY3d2wck/q2WDog938BsyVs2klsWg2bknXkNlh05D+E1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SbM9PqjxEDz3WXybyaTEV9MR6pxMSgH1vBUYSpBP/Q=;
 b=B6EBS0YkVEsnfuBg36XZrvXY0izX3kQ82wWny5z2DZr8qpL5WjeBWxPhCQyJoLTRDF9Mug4PBAoVOzUeMIR4m6RLhA2ir+fOp9zZ17bNhOGYVeqRhCGbDwp9hH1yXaEu/lqPHjSlGis+mVxfdadv8e8W3s3Ldo7Ci0H5ty+Y+pXWh1P/AqrfQ7qJlw4LmLOPw9agIz/4VeRj6YtZZtso9zUl6y/Wef9KFYwYckZ9DtKQCR2FvrS5nJKplAr34x8oBAZFkzCOJ5MLyKRg4uvIXq/bCftUfwLetT3/dsceUXpNHuPkkeqIjx218rv/tQs1DSay653uj+zs9ZmNwC12dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SbM9PqjxEDz3WXybyaTEV9MR6pxMSgH1vBUYSpBP/Q=;
 b=AdDsfoBPciiyOLqy1oNZo9+9G8ZrAyUZTxFyUBHlGzRPsPnn0oSWAG3gdDbi1KmYfStjsN9NxwGXpVaSEo21b5kiJrjM8jHDUT3A9NNxzFsXotE8wbJYFV4Rr7pAlkujHUCPcC2Dp3UI6nDTh5GKUBpJSwZCpas5kSraFVdHF8Q=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BYAPR21MB1333.namprd21.prod.outlook.com (2603:10b6:a03:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.0; Sat, 3 Sep
 2022 04:37:13 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::280:62ff:6b82:6505]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::280:62ff:6b82:6505%7]) with mapi id 15.20.5612.007; Sat, 3 Sep 2022
 04:37:13 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Topic: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Index: AQHYlVK9mP9UMt9phU6FgKvzfTQela167G3AgAGAz4CAUQOWMA==
Date:   Sat, 3 Sep 2022 04:37:12 +0000
Message-ID: <BYAPR21MB1688312AED65BEE290CF6C52D77D9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220711181825.52318-1-alexander.atanasov@virtuozzo.com>
 <BY3PR21MB30335CDAD39F927427DEF4EAD7869@BY3PR21MB3033.namprd21.prod.outlook.com>
 <20220713151927.e6w5gcb67ffh4zlx@liuwe-devbox-debian-v2>
In-Reply-To: <20220713151927.e6w5gcb67ffh4zlx@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BYAPR21MB1333:EE_
x-ms-office365-filtering-correlation-id: 4c4d0fd7-4632-4068-7625-08da8d65f8a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CzYxqgDfT994fhfRbYA07iX/fAS10IjV3BKDcBi8uG7lfI15A8TIMsvFJB2c5bQjyTh41LfA7RIb9VKtTWGiOaLTR5aR/47TlkvDXhQutZJyhusGido3YH9WoGFVxRLzk8GZ9JnsTSTY4IoiQllQ3IALdK30rbVClexf9EC5Aei/JgMo/UkYSACOKoTrAvMRfNvYBg9GXgIwzgypVhvoXZZuOgraOtdIA5R+3G5ys58z7YTHIReVOd5f9VWgVm2dSJPUQlYzamABUm8al/oaHJ8RktiaXXMx6IuMs15lqVzfv66NSAEypUfazsxsUENkq2Lcgd2FuOMV9qR35kxgOikkLMyDpaESX16WtHHOV/HaNYfcfMe2YhI4bHY8boCpt20F/hydy/xto9J8CuW7OpHmZi14hxNoeanztm9bHg70qs72RRqEUBpHnxxMT/Fa8+IefsJG5nsJ7ZLSeCULGn93jVHV/4AFibwv0dx0uJbUeOsqjQvZS1BPftUsM/A92xhpKZxivTEiUDKnDrk5AlPTUtYmRFDhSw+FEMSNav4p0KpF7YL8D7F0MMJqCxKttJPd4vABA7/d319Ljs4uH5YtMvLfioFV8zkQzwHkSibGD98VwFgASktZzprWIbbews+qYzItp/YLR9vfRCKZkF2YbCLgx3FKmm0qzHu+2Y03CQz5PwBrn9x8ZukJki5Svp78LwWZLPZ5IVmSknV8mqHtsKHXIFwKbgiPPMx/07VrVMInURlMoh7au6nPkN91/qJHzXbIxQXXcO7VWhLWrldw7c0nYSW5vtPXU0SbFbCKVXG63QAMsEJCerGakrQU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199009)(83380400001)(2906002)(38070700005)(8990500004)(186003)(55016003)(82960400001)(82950400001)(122000001)(76116006)(52536014)(5660300002)(66946007)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(8936002)(38100700002)(71200400001)(10290500003)(33656002)(41300700001)(478600001)(26005)(9686003)(7696005)(6506007)(316002)(86362001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nZhai01Hj/PIrPRcascGC7tk2amit4XZgxn5um+i8nYv7McjRNOwfyXmxYl5?=
 =?us-ascii?Q?5PDz9hys3UgMk0K2q7ctG40c5JGIqY2+kTtuzHAzQzs2CfCRUDx5gWGtt0d+?=
 =?us-ascii?Q?7TSNvI7lYV3jcu4L6zQB/Bed/BR61sM8CjEX1LzC6fhhc1/JEukQTnqfflkV?=
 =?us-ascii?Q?ZKAOlpyfOTmF+G6OvgI7XhIVtG7Xk42a5L+ENpaTtQ6u9JqxVOD0cLqPN/y5?=
 =?us-ascii?Q?RQuvq3U//WB1Q5bnurZuiBYHR/sziYq82eoRl8nqVtEim/flveFvOpmIvfRQ?=
 =?us-ascii?Q?1WyyGejjWRYvur7z6OAxkTan+FgBYDckYc68IkExo1CyIHQ9ZdioinXU/39n?=
 =?us-ascii?Q?L4nOkMk36XGh22Xiy6y+D5vaqPCRm3AEd8DHtj7a7RofANi1r2yiBbjuaENa?=
 =?us-ascii?Q?2pfuqmU+57TFtsjRvs/8+cDlvhbcmZHdy5PwwiTU6KC0Y25FBXZefh1g+6LN?=
 =?us-ascii?Q?kVKpO3XhLZuypTzRzvee4wx0uXaijGXqNPzbS2AMgQbAH99wRa4C0coBsBD6?=
 =?us-ascii?Q?TuZUxyk44IzLcrMECdEUbg0GvZ4BVGfkOU2EpANsAnqf/tKJ811+YBJ2zCDv?=
 =?us-ascii?Q?rKB1s60J0OSOfvqDn4CaXlPJF78dFUILBnoyYewPmClYWRY+W+Itv+L7iLlt?=
 =?us-ascii?Q?iexmxb1ZSV8cr/J7dXIwAjtYI6YFK/63BqniNoTwqn49R2/0WHYn+ePntpk4?=
 =?us-ascii?Q?pBKIJ/PVM9pvcMKAB+8FsUUErRDmEpSudhMQgwU+bv1xtS50EKYnzgnzZUYg?=
 =?us-ascii?Q?POCN5mC6wd0mYkSAtyftlBHp/0H5ePJuY/ofx/Axo2pzAyULCRW95qWfca6P?=
 =?us-ascii?Q?ctCvB/xYjXC0kWnI81ysGm9u9oWXnipftfEFu1UDuSYfZp/VVxyHrRKqKdhF?=
 =?us-ascii?Q?zqEKxz23n85x+bHx8VSKmpii026PNjC90WMLDMxk3BZ7+/FHoi4FeioPTZef?=
 =?us-ascii?Q?Grda2TlokJl/CLE0ib+YlRFt9LS4rPnZWKcSG04QyeTTp7mLHNhFDfG3qXRY?=
 =?us-ascii?Q?Q3khH5YF5YtTCJbgW0Jq0XgWtNxKGxznA/eUI5c3HgBgk3SslEe9HL23ZvI5?=
 =?us-ascii?Q?VhwVY1TcAQAMrjTdR5ixrKcnl6Q+AqC1KQeXOFSqCFWMJYwEmKAQatYv1w0P?=
 =?us-ascii?Q?fgJv48ftza0IcoBEufPIAj1GDrz78RqO7eBLNe/Sin4+HRhJI+nsD+JcQjcH?=
 =?us-ascii?Q?BTrvnWxjh7dJHmhzASQlyczPSzSOoT50AsCHMmRObC5vNunfZZmiNFWQtLG2?=
 =?us-ascii?Q?sg4kVYXITuzB1LPYOWrYHF3MboqcDBZDHtOSgj34DTi+OQKwADtRpPDLQj7W?=
 =?us-ascii?Q?L/hvqdfds86noEZQ4pTMCDhxyamDVYG7hs73n14M7aCjXVZ6WggMKKkx65vt?=
 =?us-ascii?Q?UaMedh2DyiX/XHRAQXsr4HLXaFSL06fvp55EuGXxpHEwFKBzeobWY2hrEFwn?=
 =?us-ascii?Q?4Dzf1paAQZCkFRmXRzvUCfnN00qrtpT66GWyjAAEsm1/Z78yyclRc6TXnnxZ?=
 =?us-ascii?Q?9mBadBhOor3lFgXKwEZG+KK6yM+BdbbA7rWyM5CaKJoLDQlhffnX8pClSdUk?=
 =?us-ascii?Q?P3TCyNFW4iHvWsLt3TMKKPq1B6N2QHHMXCswWoxsqNLO/yRYCmJH628lvi+3?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, July 13, 2022 8:19 AM
>=20
> On Tue, Jul 12, 2022 at 04:24:12PM +0000, Michael Kelley (LINUX) wrote:
> > From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Monda=
y, July
> 11, 2022 11:18 AM
> > >
> > > Allow the guest to know how much it is ballooned by the host.
> > > It is useful when debugging out of memory conditions.
> > >
> > > When host gets back memory from the guest it is accounted
> > > as used memory in the guest but the guest have no way to know
> > > how much it is actually ballooned.
> > >
> > > Expose current state, flags and max possible memory to the guest.
> > > While at it - fix a 10+ years old typo.
> > >
> > > Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> > > ---
> [...]
> >
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> I added "Drivers: hv:" prefix to the subject line and applied it to
> hyperv-next. Thanks.

Alexander -- I finally caught up on the long discussion of balloon
driver reporting that occurred over much of August.  I think your
original plan had been for each of the balloon driver to report
useful information in debugfs.  But as a result of the discussion,
it looks like virtio-balloon will be putting the information in
/proc/meminfo.  If that's the case, it seems like we should
drop these changes to the Hyper-V balloon driver,  and have
the Hyper-V balloon driver take the same approach as
virtio-balloon.

These Hyper-V balloon driver changes have already gone
into 6.0-rc1.  If we're going to drop them, we should do
the revert before 6.0 is done.

Thoughts?

Michael
