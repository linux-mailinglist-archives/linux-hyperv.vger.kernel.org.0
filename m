Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD85D6E0507
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMDFQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 23:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMDFO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 23:05:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59826A5;
        Wed, 12 Apr 2023 20:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzqYnyYiYjg1aH6a1ES2V6+3zTj8v4diSoYanBXWG95O24V5StoNClXJh4KQh0kYWt4iZLP44f98Vn4X/Am0PU3pYx9JxXNwit0Zpqd7cDin1mxAThhtoWho1ZXR/7vPtl7fdn9/NEY4Ip+UHaeRyxDybys80vjWhY119Y2YuRBxLPqdy4OyGdd0HRWdGfb4AWHePt1LcGuhBpWfFIGZ56EeYnNyDe/QF8wovT/JuSKE6X/XxPAKucXiNB+XU17epiueoauR3bt3hpEHjIcboHL/uhVok3EDIvAv1oADXY8M4baROO5Y0RT/2lyusxHwG20lkmPP34xk3skTa/Hffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvLBDgKeIjRYpMhYHxOc7u6QYdwKQYxOYvaxP2bJ7y8=;
 b=R4XoILq/7sfAOs92kxioahqT2yKp2qwyncuMVoVvUt49mJLfC293daKz/uWNAv7E7g+XCROcU8E8Lv/v03V4xlhcV0/f7CWvKspkoTZeQp0mlXEhoQPhnMwEsEQZMFxDcIv52cdlFxEgyHd2hpED45+OdmLd4/n8K4QWuvSYLChh5WORTV8DCgkcrDQ3aDG9ucM0r20uWe81LsR11JGzNmSXLuXnGAfqbOOp6I1FByl/hdcM4/vYICQkHk4aDma0/SbFieXP1pj+9NQsRUns7kg1FrwjvSFusjX0TxtotZyHwPEjCT+6Vae9MHQApB8jOlEQckSBYbgR7bQHr8zJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvLBDgKeIjRYpMhYHxOc7u6QYdwKQYxOYvaxP2bJ7y8=;
 b=RWOma14OKIK+H2QAbx9cI7D56qJMaFE1O3T/7S9MQibrWiEpIxlCqxI6Im3l2Q4NOK9tYyHcLZG+SAYvwgou30LaNsLu2WgImfFOwW5UBfiMkGc9G0g8uT6c6VMcvZUrtl9yQh8/nWuTeKqdx3Wc2RHqoNV8lN9ixTjHYlp/ppA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3575.namprd21.prod.outlook.com (2603:10b6:8:90::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.3; Thu, 13 Apr 2023 03:05:10 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 03:05:10 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Jinank Jain <jinankjain@linux.microsoft.com>,
        "g@liuwe-devbox-debian-v2" <g@liuwe-devbox-debian-v2>
CC:     Jinank Jain <jinankjain@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Thread-Topic: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Thread-Index: AQHZZum56E4siTE08ESEN+SkV6gZ4K8ofwKAgAAbefA=
Date:   Thu, 13 Apr 2023 03:05:09 +0000
Message-ID: <BYAPR21MB168827DA138ADE39298FFB37D7989@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
 <ZDdZVw9Y0q7oT1FG@liuwe-devbox-debian-v2>
In-Reply-To: <ZDdZVw9Y0q7oT1FG@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4a905326-46dd-45a6-b74f-ce90fccbfa39;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-13T03:00:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3575:EE_
x-ms-office365-filtering-correlation-id: 0085c623-6ebf-409e-b720-08db3bcbe468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUOFvDgd8ywgUwO+n4z5uoGVb8FIzQNt8ifkDYIMjh4GuTvnkKrJYtk8zSjXgvQM9O/JCr7yyPlaN1U6Fr+eomVDn6owxXqu4HMafp0fT+/x0xZnPhKN8eW0zdH0pSkHweshgJJnjLtLT2us/R2cRtnucr7u1QYPLyD1u8G+Oei9HhcCKoEK45GCnB5cwLazhZI+xPoV5j6wkMX9tclBNCBWq0NiO3qgRYa/SKjy5HiWnIbpN34jxWR2QTmwqS6x4gx3OdwXm4ab/NgA4cK/iSwYHIQfuYuaKtZjH5OpPkg3m/495ff9JGNeUgF6Thqt53hF+/hWqGpHyR/63ljcNxJomphS7Oz8utNdh3nbfKT6HGm6k6a3mUvOLwCojP0Jf4Z9RYys880AP2+zojwl5xl38TqhrfPG4viV/UMzytQWNL9rn4t7J54lf7DwNGlG5peAc+s4JBpcPcf57oQUMXlIfb5Geo3p547doQMsN+XNToX0iT7qCUQYFW6bPtQNfjAy0QhWPem86+WfpS9aZyaOsZOha7V4cq8y/1S75riDnnDV5uTWdjRH+qsRDYBDGIJlvtQeGtc/Dg47WhsPrTugP6cBG6WYPWlESirs3KDZWEwv9P2+4Yz+M/ZarfTQxC0CPt5X2S6RzUSdI/qnWSB8guiLty0TJwXoWZuE7LdhqPm5DP/wqUeUxdgKBXVy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(66446008)(4326008)(66556008)(66476007)(64756008)(66946007)(76116006)(316002)(107886003)(786003)(2906002)(41300700001)(4744005)(8990500004)(8936002)(8676002)(52536014)(5660300002)(33656002)(54906003)(10290500003)(110136005)(478600001)(55016003)(86362001)(7696005)(71200400001)(6506007)(82950400001)(38100700002)(26005)(82960400001)(122000001)(38070700005)(9686003)(186003)(781001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8xhn29fGjldJj8lRscABLOFE1rvVUt8HqLKJJ5a7YavdB4eXQohFudl/labk?=
 =?us-ascii?Q?RS9kNKdpSnyu0XvhDvbQLOHBOdEjXY3BXKn8DknGlYYo9IoGONcIAkH7xPMj?=
 =?us-ascii?Q?bkUVfzESujopjzJHg3Ad62Y6ei2umoWe9AjLWg0gOjIC7t3qJUBceW4oYX1B?=
 =?us-ascii?Q?ceQWsr7EzT/NMJpNL3Tvk7jdlw2u7Cecs7eVP6qLxH31nhw1RvNCY/wRw86g?=
 =?us-ascii?Q?10s10nGgLkwDsYG/PUQvomcYVF0ZE3OHAsLsWpDkW9lnPjX1OQsQVs/s5/UL?=
 =?us-ascii?Q?maLF9UXK3TFI5vEHPUK3ako7r11DgVyF30Z3gq+7cQe9/PqkKRnqvJvADtis?=
 =?us-ascii?Q?JJ+vTGsNasa646Y9Clx2lhsLytJKNlU8TUAFYI++GVf2433oupdY6XqqVp9O?=
 =?us-ascii?Q?+t+kurTTypKu7SbC0v9dhf3fu6srZzeLPO0ER+C3yS8+h3UwSBJyCuLn/4bg?=
 =?us-ascii?Q?E5DaHVE6HMV6bicdxaE1ymvakNq4vBWD7tmo0pbmgLbJL6eZZZi3ID5Soajf?=
 =?us-ascii?Q?eQ9K0f+AsAcPLw1ADcp7G3Uf/GqbGukGEVX8tt5fXEE/l5/3O8CAXakA5x3j?=
 =?us-ascii?Q?PEMWhLjSNNSk9x4IbzqudFEHjHgp0WfVhFwuimgK5DS7xr4sdNvPYk3b5UqZ?=
 =?us-ascii?Q?5kl09rXahnT0M5yQq+UwG99QIIgmOCom5MRUlGTC4OTl6mc7P9CzqW12UDEt?=
 =?us-ascii?Q?Pu8LDnfHD8spg4z9AiJAcQjVFOecS7CcJJp88VqHMyV9p9e+aVZ1NiX63vkG?=
 =?us-ascii?Q?eQmU5AKqbyqH027tr3EvGXF4ciRZeY7X1vQhkj7Wt3i5/xVN0Qu84bncBUzv?=
 =?us-ascii?Q?XgVoW8BjxbrdYF8veKm+I1cOcMb2xo9K4eEX4Db07Ea6HG1Hlz6GTxCVEBY1?=
 =?us-ascii?Q?5V0x7mdcqrEhZNp5MoAIojEv/4i4dKPakTTJ8iYz1eWM6xIi5pZcJ2Mq1MbV?=
 =?us-ascii?Q?S6VsDlF3KA2kaMV1Ho05FCoGJp+9hcmGPRhGS8h+Dt+o8qTJAZk2W4Jn8SV1?=
 =?us-ascii?Q?PSoTz4ePWrS3jGgSuzk5j9rIxhcDF+g5BKE6uEolYrgl6toxH5YiwODzYoB5?=
 =?us-ascii?Q?gcgSnua6Ke1dcfIUmLTffzXxAbByrSghi2CwmRPtU9/6c7iLEK8HoXGjiRtb?=
 =?us-ascii?Q?1Jj0p0Q25qAPCxvUJcA5gVxAO/Gw0dd/SK4woDdyC6XXzd5gtHYSE13nMDoN?=
 =?us-ascii?Q?c9iTgHFNBxcw7OLzyFLjphTghdNHMa+AJ5yCkoAcuW3lwF4SRbq9+w5VLvFo?=
 =?us-ascii?Q?G4pgLPebwxp1kUbF6agNfB6zn9XfWbUZ5BX1uDHNYi1RqUCfIinJPenD9fJg?=
 =?us-ascii?Q?uDMknVoYdP0azfU+G8Sze839ikQfY9KBjs7151L0sghOWDt9/e/AZWJggq03?=
 =?us-ascii?Q?i8p+I6KBo77/YE7VnIiDGMNvILTLXd4gvlFhfOFmHif8sOBYpQ0bZ7U3a4Pc?=
 =?us-ascii?Q?JL5txw5C9n0Yk6qfBwdXFJsOSByTAs3mLwidRnoZCmQ9LIbLmPn7SI9Qy3Qw?=
 =?us-ascii?Q?EZxoGc7Xn64dTwrseJIY9SYg99wzsQzGncQ5mB1gKLKeQpfJ+DFjIDxFqbdX?=
 =?us-ascii?Q?nV4D4qJHXTRvJEmDwpYV5k7WeiakdSqfVucr87WydNvhBFUp/9Hh/zDVRCUL?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0085c623-6ebf-409e-b720-08db3bcbe468
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 03:05:09.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLvqP5gkSZSPucrBPUWJbarS+MWDob8SVgdZl1Oi0B0lXqavkP/kpN7pCnFjIOiHPgJO6I7UcMiLoZlsAz55XA7ECFe8wnmsVtrhSHAGu1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3575
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, April 12, 2023 6:23 PM
>=20
> On Tue, Apr 04, 2023 at 11:35:46AM +0000, Jinank Jain wrote:
> > In case of nested MSHV, retargeting interrupt hypercall should be sent
> > to L0 hypervisor instead of L1 hypervisor.
> >
> > Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>=20
> Applied to hyperv-next. Thanks.

I'd like to hold off on taking this change.  Nuno and I are discussing
how best to handle nested hypercalls.  In addition to the proposed
nested changes,  we have hypercall changes coming as part of the
TDX and fully enlightened SNP patch sets.  If possible, I'd like to
avoid adding logic at the hv_do_hypercall() call sites.  It's not clear
whether avoiding such logic will really be feasible, but I'd like to
think about it for a bit before reaching that conclusion.

Michael

