Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC354531E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jun 2022 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbiFIRjL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jun 2022 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbiFIRjK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 13:39:10 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE8819A9;
        Thu,  9 Jun 2022 10:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKUjfLqCEnvQf7KEhTyW19f4P82Scu9aI+3shELoeP2fqCb/X7LX5onFd/8+4LD9Ca5DW3qekZsToJIv/qhxOjlNsXLh71raFaBucq4isHmlpi9onXv9xKuQX0e5qrsMBqPp6jgPKw+uJq+KbvvLRcPfDcDJmoUdLQqWm8EpRQtXE6UtSBsoozjzEA4E0flMV5uN/xmBpjsm+KM1F5G7LBgdgUxwhN96l5HOpcMN0IZgPgs7fJgR6eV6CPuAalk28rhIbT/xOa1IMxNMQWv/NdhaNJeWdf5jmyUM84QanfU/b2CGF9geW6aOWTfTE+lbz6G19Jx3VMnOgrwT4+6+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNvdR8dtejp1kKwW0ccSldobjZsLJWFqa2q8Ucu4PwE=;
 b=DK95eEEPLHoMmADBCLJndwbdLARMgshtJ5a/bAiy87aw+PKnMwi8q5PKo8kO2dlF0PRo9jtRGpMC53u9gwTB0w+PQlMgE8LrS7gUPpo9QXp6lF6nMHFHDjyCYfKWpgbrp74zwZHD6Q7tojK0uRqK5iLsAgykROJeUd2UgDGCVRdPVbvKelSDACDuYqapXRXpFWCnigDyp1mpn7Xw9RdUsXeG8ChmU9PYhu3fjrWAhUdv+pnsaTjKf6+boN7+WZr0O2V5rSL6rfxVRUu4df/0F3e10v7+m8kmHgZqYlon1uw3LLkNMuxz/XBAxP2iP/hhjyCCSUThqK4Tx7W1unAiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNvdR8dtejp1kKwW0ccSldobjZsLJWFqa2q8Ucu4PwE=;
 b=ho/m7XBxP+EU08fH6iwjHatpNtG0ZVQzyPyxAM6VRyPjsNo6YxXuFKjpdMPw4nWFFwja8K8sBxhRJVeYhU4sxw2rRgxlvsPGJGR0qYFjL/h6vo5JxkSA2TjETbGxySdqXPIi/7t/tfiYpvpN0rUm5LwqEKXj03N1QyqAANC4thw=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BL1PR21MB3112.namprd21.prod.outlook.com (2603:10b6:208:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Thu, 9 Jun
 2022 17:39:06 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d%6]) with mapi id 15.20.5353.006; Thu, 9 Jun 2022
 17:39:06 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Release cpu lock in error case
Thread-Topic: [PATCH] Drivers: hv: vmbus: Release cpu lock in error case
Thread-Index: AQHYfCSww10ypFODIE+1tTJh0v+Wz61HVzJg
Date:   Thu, 9 Jun 2022 17:39:06 +0000
Message-ID: <PH0PR21MB30259484AB91D8EA2DEBD3E7D7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654794996-13244-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1654794996-13244-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=918f2832-130b-408e-9237-c5fcc16f0ac7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-09T17:38:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c593a785-49d3-49bf-57ee-08da4a3ef39a
x-ms-traffictypediagnostic: BL1PR21MB3112:EE_
x-microsoft-antispam-prvs: <BL1PR21MB3112FCF877787EBE7FC4F610D7A79@BL1PR21MB3112.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1o4/oAbsqRCYM5ViX7kPPeVFasAn066o3SPNlOIxoeQy4+uZz9pKIo+9b/rbUkvNWEQx8b6xgy5+cYK1ueTsUTtxfrZDaK2kKAHhYNDVbvXrvPBoCBs2a5yzOI/8MGcLCCsfZk+ynVzycYr+M5I/d6M9xAgDbbL+flpkolpc3fWfDInu2DxTFQ2GoP7iF9G/kdjL2jrW1+qEh61MCn+wBnKm23E13vJ6mOPEqVBXy0lDteJAOPTtNlGi9f3+AeFA1a9Jeo9xHwO1WNEDpYdDlJ/mpIWZXQiuBqIbw0p9tw9oxZZXWdGAEQiwyJp76sC3RGToIljyiXFcckxmMYt4+ZysPgPjXnNAEEq+W+iEG130iKFkuTLOsf6Y+OO7LTFGjdVSMPdItfSl2Y2rSM+nLno7t5ilos7bKcMsWBeRi6hWVWQ4OON2btQm//PJmAjOlndmK2XMbkcY9uGRox1P7dOwiCjpTbSiqjeJKM9xIjNf3Pbvv/VqmOYCwCzvexsBo0RMmOyIpbYvZVmySj8xwuw3HfterbRz6HX2U2eE7LTbVQb6mpRq/pFru6xes+qT2nNy7RZPVO0NsIzJdQGC4wA0wHEzWhvYlpBffSCxsrangJGI8iqAxA4PViMdHR46Mtk8ryPvkzBOcx2aJAtIlAIlzTGiPTwLdmMiQtZb814kdUeLkbcRuUEwuZ4NnrTJavrt0d3fcEWhS9l7nlquVdkT42cK4OcBgLRrbPk6+A0xVtMY3U2CQpQwTbaLH7O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(52536014)(26005)(8936002)(5660300002)(71200400001)(66556008)(2906002)(38100700002)(186003)(66476007)(4744005)(8990500004)(9686003)(8676002)(86362001)(64756008)(82960400001)(7696005)(6506007)(122000001)(82950400001)(76116006)(66446008)(66946007)(38070700005)(10290500003)(508600001)(110136005)(55016003)(6636002)(316002)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/2pbvehByPJhj8OdqiV+Gga/+rm3urwNZIMMvikUXvQK5h92+LWEqLK1NrX?=
 =?us-ascii?Q?H2uBYTnQDnZNDQQOaUsWEOWtc8n8x6gPqPsw/XXOgz8Xj/usjg9TKinkkfR8?=
 =?us-ascii?Q?NyTJ7pGWxBTp6xRsfeBlOPTAgRuff95Xfyykq33LCkTmj2CzBAMISIBfGAuK?=
 =?us-ascii?Q?bYGlFEbJBm6FCK8gozT/AxmVw1VM1uSRDO2k/mQ90xJDXbcrm/QzfhNgwu4e?=
 =?us-ascii?Q?y3hY9iChpzOosfafFRO0l2F9Ahb9doj9XdFEQyJatKbBhcGofSL+ze1Yin1e?=
 =?us-ascii?Q?c36fAIn92mx3ltLhffrerwTNxaM7oN/h1OdTeNpNqQCpugR0Z7lZpNKMmnon?=
 =?us-ascii?Q?FZy2g2VzteAd7mGmG1lD6mkxFo7reLh+XT40unidpwmVMUYQ99+940/CvX3e?=
 =?us-ascii?Q?P9OpfbihgeNmxH2iWbyoEtXm4xXJt+jAxJLVlfIZUw+Dttpa/hwGm4pV9nUj?=
 =?us-ascii?Q?qa33O9vXR3UTkKBaOicxmJs/ZS7j0lJWEmrkvhJBVjGt8ieVzspVyG4rUNdm?=
 =?us-ascii?Q?AW7OsAlKzVI55QnryYJvgMs6eYOcZYI6EpSLezHCSk+dYcNWLnJ9f7ZoW5PM?=
 =?us-ascii?Q?82qYsjGTMxa9/Ogl0c6I85c1YzR0vc58G2+/aTwUF7Y1iE6jwUw/obNxaQD5?=
 =?us-ascii?Q?ZFUzAXArUXvqWdi6QLMORKaS3rJsJqMg8fh/riqr2yw8jH4lE8u6qdyX/5GC?=
 =?us-ascii?Q?Ykz/snJXdQvC62e05QyJ7z0FS6v3EU1RaBZAvAMVxMyMa/lvMo5lio4LrHtf?=
 =?us-ascii?Q?sUNh22VcqnMPT/cqFeUr0ic1VfAUEUFdTtwcSWJKDDXbLJyvriK734uZy/U+?=
 =?us-ascii?Q?jisFWB8EsuPRD1pN9Vcx2KMBlR7XiXDWDYqUCuzjiUUPLHDIf1Wt5K+ghRg8?=
 =?us-ascii?Q?M4RoIPMjO7LsuyVROgJyf1WwOKF10jEMuSgU80K+Ap1qfz4Dvanso/AlIdh+?=
 =?us-ascii?Q?CyvClfCC9henXMADPQjGbJjnk78ps4IzZg0K/s7wLM+TWd5qpma5snlwNqAR?=
 =?us-ascii?Q?KNI2vCylzPUGuDD6TcPuO81dT/nPc1BYVu4Qsjp6Z8v/vhiyYAXrKMlFoBtK?=
 =?us-ascii?Q?OeWcrV1iERqtVVqtZxMYbbdKRrvjJUOxBTKBkRMSqGgwJKg0EfgEoVBYUl46?=
 =?us-ascii?Q?FIInF3HZqNB31WZ0MbhLd1ckKGy6ncM0QIgjMEUkPoH0+1WSnq3D1f/ldk9j?=
 =?us-ascii?Q?zk1AZlvg3bBCUNS5w2ZU5+myWH5C7Nqg/8zCMPTEV2dnW+AaBPjX8fioSRGk?=
 =?us-ascii?Q?nG2IsuknEbOI6cAqp2FMV936raMaRZGUBBCnUEQe7r8YK3ldT6CpFMiVlHCp?=
 =?us-ascii?Q?jMbTgAr1eadMWyAowgUo3uREltD2HlpjzmPBFlC48U/PjX61iwSnl1g6OAEr?=
 =?us-ascii?Q?+nv8sguZDPs1dwd2/krSEk6DMIQhwCddN8CvBconLY8iwVbOKr+sJzT7/+0r?=
 =?us-ascii?Q?U/ZDWOPK2sm91Yj2duu3ER4NsD3mfZ6a022cjuuJw03eCNpu/KOO+BMLRhLK?=
 =?us-ascii?Q?+t0SnMLPLE+gDnrmXbZSbGof3BrCgp+RCDsV/50bXbV4pnRtjK65dMvs4L7/?=
 =?us-ascii?Q?MgIlESALjhzxOaNlDR8bgjEbqsEPQmnRHD4Lq3ZedcWqvSwcckw/xUp+ijvN?=
 =?us-ascii?Q?WC3MW0vjyisxYSBowN+S1/YH4kcvu98nAOESUnbvx54pODnfeq5/DOVyx1gu?=
 =?us-ascii?Q?XBzSh5tfV6rCG7qkogOrK5xRBpIavoev6gTkctXaJ751jxLvxv15ibU0WV2V?=
 =?us-ascii?Q?Q44Sr+oQ3qVCMICw1+h+S0zq+5TLTI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c593a785-49d3-49bf-57ee-08da4a3ef39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 17:39:06.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUxkU6zWoLLMgl72K7b+sRc3b5Ozl0gKuD1TMqyQZykdI05V2X5k5c9axtQWAhED1wtLjAytxNCGNzUIUe1ykVvuG+Q2eH0+ToWRktGwyfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3112
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, June 9, =
2022 10:17 AM
>=20
> In case of invalid sub channel, release cpu lock before returning.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 280b529..5b12040 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -639,6 +639,7 @@ static void vmbus_process_offer(struct vmbus_channel
> *newchannel)
>  		 */
>  		if (newchannel->offermsg.offer.sub_channel_index =3D=3D 0) {
>  			mutex_unlock(&vmbus_connection.channel_mutex);
> +			cpus_read_unlock();
>  			/*
>  			 * Don't call free_channel(), because newchannel->kobj
>  			 * is not initialized yet.
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

