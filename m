Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAE8536DB7
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 May 2022 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiE1QHn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 May 2022 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiE1QHm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 May 2022 12:07:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED646270E;
        Sat, 28 May 2022 09:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTxYYS95IVQh1HDOGeiyIqoFytixJ3sOuTkt2QcTwX+Yg1K9SvoUI2eorc5fzyHNIp/KmxJqmloclyhtl93E10zPxaZeOSd9pFxviesc7Dnu625bl2YIKiG/Olxhy+7MlkteOEQ4bAP4zi+Kfv4vEEau+AZ1BIxWnwFocLPuCjTtKFgpKzFeUIc5Li9Oa2ewmqkEQ06ZYgUw+nzlGae4QRdEvOa7CQ8JAqTIGS1QzKTuPMPSjs1IIw67qOOYV0bW6/CADi3kXW+Ns82Yo2ZMTplvhwuTYZJeYJtT0HnpOOyp2YcGuLea+tDKxFO9QicevbFPx/vAuKMWJNEgwquo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXLiqYHCfkpnNM3sry/DPQh62oUKDUidWbVs/MzN0zg=;
 b=X3xu5FWQ9Bri4y+kZf/ibLRrH0gecQgayBErnwSPFfgHOc16q2J7cW/9XdOylkSlcYwcj8BTUnKxOP7MgasJ5SoTw9uAxr3ooH0NfnhRv2GTcxy0L/s6OZ2JWQ+UqAK9KhiBVX3DmPoC7Xk1oVAOTbF9k+xCPXdBcoXZsOThXrrrR/DxwcA4/psXQZOFY9ZC+7R7b7pIZ9AEKjKJw3YUij5MlTgMe5jP5pkLXf9MhsTEKjWwET9i2OjPLoAQcfReU7PncsPkfCIh4J7s47a752826PV40eqiyGtl7wNja+DOrn1w+1a41fzBHQtJ66WSreHBUVDaLEfo0WqEVN5GIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXLiqYHCfkpnNM3sry/DPQh62oUKDUidWbVs/MzN0zg=;
 b=PHAaKoE2yG+0ra3KLMheTL3GhL8lj2RDd8dZlJmRk5ImoC+gcGm6eG1Ka4wk2bI7V1jYt7LKNlpxy1YEfDDmSjZPBqXhLw+7j5IdowrK6/Xw+B1uLhvaYo2rl0EqfNo5SSstcOErTsmLrn4ZC3XGd4hCVrptXtlomKt1EZpDVV4=
Received: from MW2PR2101MB1035.namprd21.prod.outlook.com (2603:10b6:302:a::11)
 by BL1PR21MB3280.namprd21.prod.outlook.com (2603:10b6:208:398::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.0; Sat, 28 May
 2022 16:07:35 +0000
Received: from MW2PR2101MB1035.namprd21.prod.outlook.com
 ([fe80::d02a:a4e1:e2a7:beed]) by MW2PR2101MB1035.namprd21.prod.outlook.com
 ([fe80::d02a:a4e1:e2a7:beed%9]) with mapi id 15.20.5314.006; Sat, 28 May 2022
 16:07:35 +0000
From:   Stephen Hemminger <sthemmin@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Index: AQHYcZqCuyoQmicyPkmbcJqVfL10360y3SZQgAFkOoCAADTLYA==
Date:   Sat, 28 May 2022 16:07:35 +0000
Message-ID: <MW2PR2101MB1035A1720D2AA694D07FAD1ECCDB9@MW2PR2101MB1035.namprd21.prod.outlook.com>
References: <1653636136-19643-1-git-send-email-ssengar@linux.microsoft.com>
 <MW2PR2101MB10354159598C83FF6EF6777ACCD89@MW2PR2101MB1035.namprd21.prod.outlook.com>
 <BY3PR21MB30331525C557EB7E46A66132D7DB9@BY3PR21MB3033.namprd21.prod.outlook.com>
In-Reply-To: <BY3PR21MB30331525C557EB7E46A66132D7DB9@BY3PR21MB3033.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d727467-68ff-48b3-81de-b31cda484a30;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-27T15:41:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7b47c11-4386-4fa5-c7c3-08da40c42de1
x-ms-traffictypediagnostic: BL1PR21MB3280:EE_
x-microsoft-antispam-prvs: <BL1PR21MB328098C3F4FB20C9572421D6CCDB9@BL1PR21MB3280.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k71CjOYCojKcEdrXAUJPbZYVJyQQ9gMYataQuUFWdQ2vG3N/sMqbBteQ/XHZipE7qoIpEGVDLgDzSN8TBAwx5s8yxLMvNBJky7jfFcHr4aC6iO2hZkYmqz3bnVDXYM8rfwr94FmNyfTiIC1t8I+Y7y6qEKTSBLHjRQQDXQat9zkn4xb1GSPxuGeIuAwEDYXlwjulhkeU75Jg8s4KCf74YXOg/i5W8ki7EWATLWUi5Zhf+BsK8n7ORYiSjTCyiNOz16LAt5so7al5w74SmDZLk9Zc3T1ADNnUOMFll8yK5RgOPl20hK8ZA8lqy4cnUXtyGQo4C4sUpny6/ZmGSUmPktWFFomCc42pva5EJb5GELY7/oH19uASPL0ZKmyj35lhJ8hkxYSbcYG7SqliUWyDHSCjGQnCZiv1ggmJvdGu5rORTu4vQKHSOrbuka3a340BfAx5ZM2qFKidFHCeaFtxlrpe+f//hrqjX1u3eaxME2167JkjT+bKxkpy1Jm4vigR5J+KJI4my1DKXx0ZZMIQiuZzShYzF+wlrgqcrNMSQ2YPGfTO2w/gb1Azgsnb+JzULuFhzQGhLG1v1ZuLtUU3+e2vGtodsdBXCKWogfGrcBSgoCY2FkRiLtwMur4qjJtyWVTJpuklFE05kCCZNoMDsWyOQsphKibOjcEntnkGjRTgalMCR38WBFbugYA3oUZqpct0irDVjmBrh3S+WBqkr2nHtiEs4J0P9fmU5BkBeYFfKykORdmQFx9v9yOLhHWBI0A6dmqRKuGovfl9SUDptps/CU/MuPP8AGBVlloxyGjdWg5OuTd9zBUjm5MMYF9RHUM0IN69ktMbVF7sljuRDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1035.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(33656002)(38100700002)(8990500004)(8676002)(64756008)(76116006)(66446008)(66476007)(66556008)(66946007)(55016003)(508600001)(6636002)(38070700005)(316002)(86362001)(10290500003)(71200400001)(966005)(110136005)(26005)(9686003)(53546011)(122000001)(6506007)(7696005)(82960400001)(82950400001)(5660300002)(83380400001)(8936002)(52536014)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7nZOosCNetJBanS1zb0JrbrkHVbe5UMmI9mefxThTXe5WbUpZslFFz9BhKot?=
 =?us-ascii?Q?X1f493pQGcHc+asL8++BWcmi0092v+n6QPtuUqYQ7bRHqIyO97ajv0fb1Vw9?=
 =?us-ascii?Q?Un4UrgML6GCBsMLRW94MgZBlFPAKFD0wVK04uMxbRzrC/IYja0DNCJNzH1YR?=
 =?us-ascii?Q?Zpx/k0pwldx93WlJuG0vA9/P4ZaXk0VstNcljjeUQK4tnnZsj+gJq4Rr2CTs?=
 =?us-ascii?Q?VTIARxwoMiIYgrYx8cHKrhkWsVSG9MkTCxR+rYvSlrd54Dlz+ZQb7038Bkm2?=
 =?us-ascii?Q?83NUFU9eRv6yZoUo7LdUZw+wsUl3VFO5EAnBnvDLm5VO1uy2AR2kJRq3MEWY?=
 =?us-ascii?Q?OcFecfoq867feQ5RtOOcZyBkj13M26M8VZZz1M7HUIhP+WiDQnXgsrpcHIIH?=
 =?us-ascii?Q?XdEkw4YCnqIvDY3P/S9FKgMwsl/WmYRT1D1QpR6cFJypN4H9Oq9FY6/VZoQ/?=
 =?us-ascii?Q?E4R6Ep2f6nSjIZkYzsFJ8Ba7MGenrJK67lECFCZnqYjdj9mTIen1oq8iJ1Ng?=
 =?us-ascii?Q?ptQT0rPcf9o+N53bRtZXASSfxTTsaIkcTAgoettaZRLCPATpibmNPSnLijrI?=
 =?us-ascii?Q?KUeE12tj4ymI4c7SOzxLmY8mMNLW0n1Xkjs2bj084xm7QvzwOt8t/JhE0ufk?=
 =?us-ascii?Q?8ICYI3iofT8jwqfXUkctRrOgzBGK3uLEzqvCHZT28I9sJuJwbPG7Q20eJchZ?=
 =?us-ascii?Q?8FcUt2ltUlW+31LxxUqjaaEFZg9zy38o5zUZI+7t7gH79PMQEWiY0MrLp0Q6?=
 =?us-ascii?Q?bZBuh0VlmNPq4esSBuT3YPjnR20XCO6xraszvhNZTU04BZQK3IXozf33X/M+?=
 =?us-ascii?Q?D9oWBXBozdcDGYiLulx70beT4/ITZCgtfuia1e0ZbrB8El7HmT5j5keijX3M?=
 =?us-ascii?Q?cPInPWJ6ouVtV5he5TVpXCyi0wUht0VFSMaJa68OSNhgO0EvjUIZub5rXWMD?=
 =?us-ascii?Q?8kqhyXli36W9Q6dkCdYrcvXZmOR3lyf+XOHTgTq3UXco0g3zqngHrcx0J09Y?=
 =?us-ascii?Q?axMdS6lH83RYWykyhDj4mFcjSCwSgsqfg4+vTK3hjdfoELPNux2DnMe5UDZC?=
 =?us-ascii?Q?fEfnj8ZscScbSk9cS0r7J+2npA7kQvX7jGq4+loWTTbK2vnFRxdczF5ijE4M?=
 =?us-ascii?Q?AVTu9vLmKskoYpwH0JB5Y21NJYQ+XwDaoHECQH6GGpxqKwSkpJMwHjOKzvf/?=
 =?us-ascii?Q?8VFEWosxbdIpjQpxGiVEMQdTYPYoEf5ZPvrGlkDRXOJKIg2a26nglFkgQQ/6?=
 =?us-ascii?Q?tV5GZbZEzn0vLgYQSU7i8yfM+8eiofRZ1AIqMx0fqBJhZOaC6wCcego276HQ?=
 =?us-ascii?Q?jeTTqRlBRkFc9iukui9uDdXcGMTBG6vgotvIGuVrmvWm0wOjAVyuEYd3qDwT?=
 =?us-ascii?Q?h6nuGoChn4k9QnMra4JPiIVDIorP9Dqe/yN0ysSxjNepdyv5Vlz5F5u+iIPk?=
 =?us-ascii?Q?w1IAWjgxrTm8ykDiw5rMh928Mj8LLcMYsTe+t1Xxyuf23ReL48BnQmgrf/F8?=
 =?us-ascii?Q?Tj/TIGVwUEplJu7iuJI+NBOhO6NT7calsXimQouolTQk9NOrNkdnhyHl0jOa?=
 =?us-ascii?Q?1CQFmQRQ0wRNqT0tTYLh2eTbNmAn8uXWZCWJtWXQI6WIDgSIO8Kama9dBVTx?=
 =?us-ascii?Q?4HcKS7Z+yA9x6V357zjhtErvfNID1SxVP3YJLRFOEwZilPaiVcm5l5+ST+CS?=
 =?us-ascii?Q?qE8t+58TpscByYRFyWgF0jiwUvcGtY/5FeImPZ1/DCGsAvpuPCN9iuLNCn8t?=
 =?us-ascii?Q?FapsV+qNCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1035.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b47c11-4386-4fa5-c7c3-08da40c42de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2022 16:07:35.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4BCNsMXY86OelnJkOP/XJAAH4oQrAx6PqPju3bSEYaDVM0F7XbvfAS3eWDAUo46MZxWLAKyHX483umrk3glew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Doing this will actually help DPDK applications on isolated cpus.
The history is isolated cpus came  first, then cpusets and now the preferre=
d kernel solution is cgroups.

For PCI hardware this is handled in userspace typically since it is a polic=
y decision.

-----Original Message-----
From: Michael Kelley (LINUX) <mikelley@microsoft.com>=20
Sent: Saturday, May 28, 2022 5:56 AM
To: Stephen Hemminger <sthemmin@microsoft.com>; Saurabh Sengar <ssengar@lin=
ux.microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyan=
gz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; li=
nux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; Saurabh Singh Sen=
gar <ssengar@microsoft.com>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel inte=
rrupts to isolated CPUs

From: Stephen Hemminger <sthemmin@microsoft.com> Sent: Friday, May 27, 2022=
 8:41 AM
>=20
> Would this have impact for DPDK applications using isolated cpus?

I don't have any existing knowledge of DPDK use of isolated CPUs,
so someone with more expertise feel free to correct me.

From what I see in the DPDK documentation (Section 8.3 here:
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc.dpd=
k.org%2Fguides%2Flinux_gsg%2Fenable_func.html&amp;data=3D05%7C01%7Csthemmin=
%40microsoft.com%7C45f1aefca73845a7470408da40a96d81%7C72f988bf86f141af91ab2=
d7cd011db47%7C1%7C0%7C637893393679306569%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am=
p;sdata=3DvT3keyehM9AWGhPJ9ItWJhhjN%2Bl7ZGB07l1KapOG0I0%3D&amp;reserved=3D0=
), there's
no impact.  The example in that documentation does CPU isolation
only for the purpose of scheduling, not for interrupts.  The
example kernel command line is:

isolcpus=3D2,4,6

which defaults to "domain" as the "flag" and is equivalent to:

isolcpus=3Ddomain,2,4,6.

VMbus channel interrupts are affected only if "managed_irq" is
specified as the flag per the commit message below.

And FWIW, cpusets provide a better way to doing scheduler
isolation than the isolcpus kernel boot option.  Perhaps the
DPDK documentation should be updated. :-)

Michael

