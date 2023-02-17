Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA40D69B2C8
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 20:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBQTAU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 14:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBQTAU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 14:00:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2138.outbound.protection.outlook.com [40.107.92.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472EC61870;
        Fri, 17 Feb 2023 11:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5nBtwek361oQS1HdybOy+fggef3tRQ65aggn3XtNs2PnCX5LUoPevT8cYpaVDhK0flc7kDIe+Y+lfNM+FJb0whs0d3vhaRrjY9LQdX9FmPlAAkXwdalIC7ZmfkfIbiDAEI8m6jG+Egh1G015VVOAIJ0T7hc7ttkOQ+qr1egMVMOqJ9v4qyYPVpd8Iue53Z6Xx3l0cxrdVubAyGUl8WeNL7wN+IYfMaqzzeyEsNsRT3nXx2JqHihskKQpl9lFTrwepc/9zm3zJo0A8JPvio0Y1cXta+2Yx6nssJ/Ca7+W7MsPqAArSKO862sbd9F8h6FNLgbQsOf56Gp5VDCp6yUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTtgMvamhFSFVUK5KnHmVvoMyfs74y1dWlNhx+E10zo=;
 b=NCn4iZSlSUFqt9dvOUGhwnAF2UdR7QqZV2XrniY5DCjdBgagg4Yw0kzcB7rg94UNnAVY+AXkR3ZokdgnVKo/NOgMhcjXddI+zZT5zq1DwN7LOqpmVCjbcP5rEpMWzqU9HNH5DZRpUbr+hU/byo196dZjzjMpNQj5T5y/SN6UZ+nfnvCERyjOpQyyOVCpX3QuZ5uU+BTDV+7kp8B7J+Hbw2U4JQjTv7PrvEdlIy3rjfT1xX5/SbuWreF+lBHHD3Bx8eyTaPYaWtTqYbf+iGHmuxgGG5gICLtMYkhwyHar1YrpAitAliEQDjcWlKrH7mp9kXRJQQLDQY1otdHQuTACqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTtgMvamhFSFVUK5KnHmVvoMyfs74y1dWlNhx+E10zo=;
 b=CEpmGdf4GrUU8NWuUwzwJR3kob82KpoiYPgDMVdnO/yNUK3FQ0hYy03IC1XRSMt+NVlT9XKcX8RMdis3HKt6KiuBpqGzvsPXpbfp1KABFvoSWgzl70pLeexIrVI3VcQ0y9iHms0/IWVU+AAUADjFD2XFvEGv/LZ5MdUUX+DGBO0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3379.namprd21.prod.outlook.com (2603:10b6:208:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 19:00:09 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2%3]) with mapi id 15.20.6134.013; Fri, 17 Feb 2023
 19:00:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Subject: RE: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZQGdq9M/Cyc8biEehOWpQHv+73q7SrIAggAA9jYCAAJdIQA==
Date:   Fri, 17 Feb 2023 19:00:08 +0000
Message-ID: <SA1PR21MB1335D6E10CF9043EA74573F7BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230214112741.133900-1-mgamal@redhat.com>
 <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
 <87a61cpql0.fsf@ovpn-192-159.brq.redhat.com>
In-Reply-To: <87a61cpql0.fsf@ovpn-192-159.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9d0c6b3b-4698-4bc9-a34e-7163be791b5f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T18:53:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3379:EE_
x-ms-office365-filtering-correlation-id: 3e4ad22e-3401-4585-27b9-08db1119308e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvQ5HKEIcgLx2aLwMPqUADXhAyTWvhEjbzDlUlYXF/SlBjL0NXbPChqTf7vCQrUv63EXRZ/5XugKwAuai3ea7ECta1MdKCdrMv1bk8OnVDYybepya3AliqrXh0OYAXedNr+uynpfVvilLYKOyqgIqObpMARTUcX4h6SBDda6pXlMTzXgrbgRVBUHJkxcCNF1RZ9p+FLYQR/7hYm14v4kSHLzBM7S5se122BxFEkfTfQR49p2p0orfYl1pMNkl66DEpnBYja3dMyUDjGyY6IL5sIKYJFqUSmroTV6lZAoMbWNQZEI1O/7xpFeZZRI45MXivOwojg0MZYCeWNctO/Xtzm+QTASNGICUMPZu6G9BXt88W2sgn6eT6bvAsT5sjOLcUl9NZ/aHyL/A16712iopi71dCn4oM8fvM2v912d1bnm8aUqhR9T6o6ldXjoL90EcxhTUX9Ee4pGp10SkG9uSH0LTMYb2oN10BtIh7pIwI6BFgS2n/YnGjBZN2C7Q9iNMmVH0vb8ZMWiI/TqrVUjCj2RmS0z0RE5JQmW9ACLcYFHQmCAHwTHE6/QQXuwyZOyCEo3h7UMr2x4S6JUgFFxcgkRbmDII3lAMRPaBvbBM1OlY3m1metRn2ItTOoTSiw59Tam2v4rZIWfRmDFIs/8MGWBNvg+kcEgmiog+Zzyvi19MIUh5Hfs276wpZ3dq4zAGD2ejf/+nMHO9s6avPfScRPgBNAfWUcJ1N5OkVxRoxhO2QU87M1ucU+uYtXPJ1+T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(38070700005)(82960400001)(82950400001)(55016003)(558084003)(33656002)(86362001)(7696005)(10290500003)(71200400001)(110136005)(6506007)(316002)(54906003)(186003)(26005)(9686003)(122000001)(2906002)(478600001)(8990500004)(5660300002)(38100700002)(52536014)(66946007)(76116006)(41300700001)(66446008)(66476007)(64756008)(8936002)(66556008)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AeAig4NFx7r27I+dK681IJqetYadqQ9JkUYbygobUsmoA30c77BhHX84gu1g?=
 =?us-ascii?Q?s+cXKEnT1OZBmpsjZ+duKbQt4+EzVjmpQeq/e2/vr5KVs2mtK/ZoXHQ6FuB1?=
 =?us-ascii?Q?ag4WvYalVdm1OBOUXpMIV3VAqYCr7ucwLxNkuYHvZwWdjiVGoHZBxt1/zmAH?=
 =?us-ascii?Q?CxBW/uIWEAfo3UHx+2YEdpPjXZ86nNvDIVR558PeaM/fNqTQvFXiuEUVOL/6?=
 =?us-ascii?Q?IP9KcOBYKHFQYqbImUYjWP0godem89dRk5YNlaQr/Kn2RF9XZjqXPVJGkGJu?=
 =?us-ascii?Q?isXHx24YfriDrxdoQn+EWpMzVdzxdimwoqXK/HjZbujAredr/ONnKn2kisIU?=
 =?us-ascii?Q?Yb9yfRA0oTW53NX/nNl41JKPMpdc1eSrYg68a+0v8Y2ilZ8OKfstO/x6KVI4?=
 =?us-ascii?Q?HJ9TPAuBxPXgz5BLJRm+SIO2O8AC/c9Uiw+mCyxuDXDmzwICiUM3fp/5v8rQ?=
 =?us-ascii?Q?g4ATYyldVF0wSJ92VtCGurn2noSvv0VRyB2bKp5YCQtFHY0EBIgZQY0CDl0p?=
 =?us-ascii?Q?p9MvSSOJcGxc1YQcs7mY3NVa6C3jnPDSRz9LHhjXBvGHV0AwBcaArhBz0L+z?=
 =?us-ascii?Q?3I19GS0aOdByp79Xf8vFLurrdyFNWSxcIb+afeQznf6rdLUcCcV165yA54kZ?=
 =?us-ascii?Q?8axmzbke8ICg6zUDzFSKj3g6+zqFfx/aJDcdzm5OZFP0azha8klIXxt4C6hX?=
 =?us-ascii?Q?Tb5CzLIIgQ2DziQ8XNA9FtwxMxbTYTzGGN4vSzAKrBhClPeILSzQ9Y1otUA+?=
 =?us-ascii?Q?jUNgbVvcd9yKdsMBI9VclGshAx+AHJpgBRPAcYFwsRCvuKFiwDoNDseqTpjs?=
 =?us-ascii?Q?ikffKDIHYKJ/cUWbm13J5oCNbR0SdZ5xWKcua4VtZV0P5xLInqGQkUXDkcSx?=
 =?us-ascii?Q?95in4t9LRyMIhBSN2XGhhr6h3poxRwP4Led42J9HBGCm9p8NiMOZ0Smap+Ns?=
 =?us-ascii?Q?6o5xkgkfHTIM/T/CjgROY8RG58kRGQiPGaQhBCX4DC1rnYjIFoqd84qUXovX?=
 =?us-ascii?Q?RuqOdYIMHmWpEV7VW3tnGUdQTQnsLd+SdRH0g1t9mMtWo1giT9wuezrrYS14?=
 =?us-ascii?Q?dK5RazTTCutEl314YK1bLtrsnto0oAKztZky3btccNrAG394reJw1jXjAZQj?=
 =?us-ascii?Q?EgX09MvSQnpQ+aRkcEIUojtdClqVEdVQQhI3eopFX7mfldKhHSFpSp5zedQc?=
 =?us-ascii?Q?IzFeBCO8KBnVRF8zC9tR1oSPvi4cX7AFYUVCWYb9I3i6hxBEGv55oZ035HVo?=
 =?us-ascii?Q?+maKfKQx8B8HRsHMZdiZnugFGCRdhQMQrpJXn9Gp1zC8efARHd1kiG3SCIlj?=
 =?us-ascii?Q?zD3gmkV8wlxpRt3zUwCbgvj/N19zGvutCMIc97x1D3IuN1JXxGFA/DMeEGP3?=
 =?us-ascii?Q?6ymIDX1+cTIH9syRxwKY/tEu86jRF/slhUwr+XPJMMtFXAY6i0hcLeFYrAjT?=
 =?us-ascii?Q?k/+AUY/A4El/5IlgDxG9wbFMnGYT7lmAs970Z6gkA7Pm9BeXFFyTK2VxkqGa?=
 =?us-ascii?Q?z4BTmdxCYhOBpPSbG4Va+LZXyp7NoY9FhwGcWIjlpbc+jBXIfIUg2g7H9LtA?=
 =?us-ascii?Q?bv24+ZcLE+X9gpfB0qCpvH1uG4ti+TR0S/l3MUPh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4ad22e-3401-4585-27b9-08db1119308e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 19:00:08.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRbZrq42wp5RGRYZ0BNUIeHemlgP2N7UX/eB1x2ulb0U0M8shzDAlqIbhtUutAKX2EDtyt2jB2B0SsstY18c7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, February 17, 2023 1:52 AM
>=20
> I'd even suggest to make it pr_warn_once() to be
> safe. In theory, vmbus_chan_sched() call site looks like it can create a
> lot of noise.
=20
Good point.
