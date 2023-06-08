Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74977282E3
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jun 2023 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjFHOj3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jun 2023 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjFHOj1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jun 2023 10:39:27 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90F2D59;
        Thu,  8 Jun 2023 07:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1+bopyTzzUHGkmm6jXaDrr01Y0V4rfMApuHlSZvHwMruBLYS/aYTtrKAp1KTyp8fhQN17MXRi+l4FKpMsAtxvXokXba6s5CRpNQopLJfv1EY909YNbDHJ6FyhsmlD2UgCQTQ6kO46yZn+iQJOVAj4MKVcbTBnGshCNXm6YIZOgNrX//z4f1TI/ap4eyrBDVcMSdtZixnlE4sDAmkQB6OxnyakXaVvCdZaFc7YYHx5p4vUBBzXaBJTfzF/WfYpMA0BPW1zMnTmuaeP0VMPzFga/I/COSV0oNtxsB0e/4cZgwX5hKRcVOmyxxgteCGH6xLMHZFOuBWqAuZNB/wxzClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sGKz5NHkNKptq0G+ggqW7DenqGyO6yHM8r2y52W8Z0=;
 b=lrase6x0djZFgl76LaXfGtxAc7xH9efBXANX6TlNAXtHLYBi8BQSoxZe6GrfP5NZS7uEvLocV5QSuNi48JUOphmCof1IVdzfc6BEC7BucjHkK7aE6dJnEf3vXkSFX+V8PFCWgaafnsk6XWECSTOarL4TXa3nIQQmVfNg2kQPuSj9LrhlWZipOnzO8ajZxJ4HCI9KdTN7RCQFG2wPHwTGfFtaMCXEMnTmOzjsAO/jdV9EcncToF0fNEBmuAjpLKIUzYe+I5w7Ym6KqaFNGuHoIBPc8lojK0wsSM6Vl22BI5NvIpsadldAkPdYDUVFiNglhqP/712Vl4JXz6bkOP6JSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sGKz5NHkNKptq0G+ggqW7DenqGyO6yHM8r2y52W8Z0=;
 b=aKTDa8nsjQgBg+KTU4xGjJ1lMuzKjdGHLu+yy8+Lc+CUGbNgjWHz0eY358+8QlEg4qVViY0wPCc/GpJsZ6xh3WT4b2WPR8/qWwzp/nbmhk7fDc1m9gJ6zTXSNWUP0WTay6rnp1njkk6WJlxsWZzhBmZER02JUxURbKeGCl0EzPY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3046.namprd21.prod.outlook.com (2603:10b6:510:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.12; Thu, 8 Jun
 2023 14:39:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 14:39:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Thread-Topic: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Thread-Index: AQHZjZob2yLFJBtHgUi6CCUhYCqkka9oNBYAgBjdbLA=
Date:   Thu, 8 Jun 2023 14:39:23 +0000
Message-ID: <BYAPR21MB168882149A235E16CDECA1D8D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
 <ZG0LTAeV+KMAGXIq@liuwe-devbox-debian-v2>
In-Reply-To: <ZG0LTAeV+KMAGXIq@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90ce544f-5797-4f90-b34c-2d3f5a2ee06a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T14:34:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3046:EE_
x-ms-office365-filtering-correlation-id: 9cd6b409-4eb5-40bd-cdee-08db682e26d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5l/LK0LZTkqtMAZ1QcEiNuoRKWmtSBKvTCLOxcYjq/hw6uUwxgAZN/J4DV5fGZH5i/HPp6ct8xMBrUu3WnAeQKoAky4AybnQ0AtM75uH5PffBFV6WHus6o2dVjnIRfj3eChLF6fH54BepJaqhS47GUAEIB2RJswj6AfvqQ/Bl1soRXQg35HMsbTk4KjI4wVv8EDfY2+3FWi/qROnoKtCBDugNo9MKMynOk/8shOB/sHeVn50+XZbfEQ/wkSCKaez8W4J5cdeL5IU0mAt4UhmoTLrjYpnYqyzPj9ggmbczSN0Xh8DZGBXpL0NYncthW12xGwHRUQUbATNVYSrlWtcRYORdY7WTCVihah+5WyLxkTP6eMxR1Zdy9fKOx8d2Pb/CvLFQSfc0NjYYGbiD4Su9y4hqJ/kASlk6hKQ41h0AWpZWY5euy0N6Rz2TscjsQ1mh+OmkGUOBw61NpTLJ/OmJWlEhmOyX3AvGh+YeqPTtZHZ2wZJjjCWLU4/BF+QYpyMa+dn18MdZYVYidR2IZgwEVOLGiqbdZPBFJ0dowiJGkjzplXWCBpq5bEBbK0DP7hbLTSUlbdyFQZG9s2Bng2rZjQJYUt7sH0vE0oeF5W1BCo4LlPdShcwyS3JnBA7GVtTH5LLUJAvbSOqyyoKoDY0MdE8r/bOSByB+yd6dL5d3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(7696005)(316002)(41300700001)(83380400001)(8990500004)(86362001)(38070700005)(9686003)(186003)(6506007)(7416002)(26005)(2906002)(4744005)(33656002)(55016003)(122000001)(82950400001)(82960400001)(38100700002)(52536014)(5660300002)(8936002)(8676002)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(54906003)(478600001)(10290500003)(71200400001)(4326008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yVb03tq7IqwjVe9pB/LogZPhmgXIk4YGnagB/a4VPtthgCLIHOAhCvHBnWZE?=
 =?us-ascii?Q?FSC52TgtTnQaTFNsVqS/iPNYIuSTbPDHtvZFlYJQ7dIuNrkKPIFtW7xygsFp?=
 =?us-ascii?Q?BBuB1gdhofDYVLZ/zVZvqSSKsOLdT2tNYcM6ommiziHnT3tMMPP8HGBduDxS?=
 =?us-ascii?Q?kQIRyYXHJK/cNS1tnn36nAXSwnejoVyUOk160DpuwWC+nVuHriBRiKLD3VGP?=
 =?us-ascii?Q?EQbLY3+G7aDIIWgxYzkhWGOIvgIR6PycV3d3/hQ+PDOJRvEXQsUAMhTCJybI?=
 =?us-ascii?Q?CxqBwAgqQqC1d/yj+Tu6iH41iObvJvF1ckcFobWR6zIS2HPFTRUtT6ZkSM+y?=
 =?us-ascii?Q?KXBcNcwIioqb5kCKMXFqPW5XQJVBdIwxZe1vBb+Hj4dD1oCj8Eiq5vrX8iO3?=
 =?us-ascii?Q?qwaJ1w9aWiAL6iigGwwpJbovIrGceTRu9wxoZWQjaDpYs2Xz2tXPAfcTHMcI?=
 =?us-ascii?Q?6c9IvwK9Zx+EXv/GXOwlkz4JKJy2WuiYcHMPrMORZ8YStvGQ2DAEH1qpAVuU?=
 =?us-ascii?Q?Q7G+khEKF0hOnONdrVlEM2sZ6AEtIse1R22zQGDSk6MM+9TAI01oxH7P/xBw?=
 =?us-ascii?Q?JrMpeS7BWnVBGqLrt2LAw+qBGrQ5kZtkNi53gruar6Ca3GBNyqGgU7xPBVqM?=
 =?us-ascii?Q?xwrmZgn9VxnLxDMtAyCriU9N5WDuibqI3bhFg11n4gfQz8a2xjJCErHefrkC?=
 =?us-ascii?Q?pTN02EehngJNPB8Hvm16mcNUDcEqSAJURYnrfkUWNRnWh0bqSiR1jQNEb9BM?=
 =?us-ascii?Q?W2vuMQXGakQWJAXaIMf/Q/kawg54dnqwVlEoEEUEYxL10RqszAuxTXGYeAiS?=
 =?us-ascii?Q?OBEpXOuNkBvw+22QPNtyAvD4Pc4Ju+8Ve5CrgI7q1Hmp3ixSPoY60asVNiZa?=
 =?us-ascii?Q?hJdgoXImNSjAnkCXo0s/FLjV8iOSWikFnLBJC/OC/tvt0cEMY1Dh+wgTmujI?=
 =?us-ascii?Q?bP3en1ZXLUKna41cniIG8cgo1agaQ/tzQiBQ5JVoRXhqyMpsHEZ66PWXx9Eo?=
 =?us-ascii?Q?QecJMDgK9J3YnzminlM05D4dXwUJDjHcq0SINTHc5dJqtW+x+tuI9zcilaw0?=
 =?us-ascii?Q?2hDBVb+Qcgp7Ox3mkbJN+Vjz26jpmQnYwVQBRb5e0XRs5T23+R1wqCa9W0Hs?=
 =?us-ascii?Q?CrJOcKn1aRy5jCFUlHRTz9ucWQLB7erX8M6FisweLsXpLI4BOb6enIkYg4bH?=
 =?us-ascii?Q?4SaHhow1DmCyXUmb/JBHBJLS4StL/o0ePs9LtTNI4oZVJgUaiFUPBnbJGFm1?=
 =?us-ascii?Q?sdZODJq48Xw+ayx4tdzNSB0tTS4fhlhzwJ781pXFG5p3T7h80sm7Ijp/WJ/k?=
 =?us-ascii?Q?zh2CL++N815yu3TG1itIyI7IHL9JJlCYVSZ9VLfOQp0fbc4xH+0wMdOUF5s5?=
 =?us-ascii?Q?dT0lJVWJDxYNvoDnwVZa+7fn9gxNI5v2LUIVT3ttfpz03hJaUol3wLiorR8D?=
 =?us-ascii?Q?dCAQQ/UdTHXyMzAR0WCbOytd9H9GHpCjoYETcOJy6eyjgpSWiPe09XlftT0g?=
 =?us-ascii?Q?qbUYDDGVk5z4sHuDM0l5D1dOrj5xRVs1e1XO0Fm3GANd0CHBCgW36YogTzFt?=
 =?us-ascii?Q?UFxa+3WClrXzihrrJRtTTDYSM1VilA7rwS72UisNm/ax5nhZJ4u2XSythK3g?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd6b409-4eb5-40bd-cdee-08db682e26d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:39:23.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PUs1XI53b9eMI51LALi1niwuajAO79hkXi7ZfIMCK8QwdLprl5H1tXW3NrdSJwxgt0z7HJdCbLiVxZErtpvB9pUqer9xQTDti1eUZ1e9/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org>
>=20
> On Tue, May 23, 2023 at 10:14:21AM -0700, Michael Kelley wrote:
> [...]
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 0f1001d..3ceb9df 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -200,6 +200,7 @@ enum cpuhp_state {
> >
> >  	/* Online section invoked on the hotplugged CPU from the hotplug thre=
ad */
> >  	CPUHP_AP_ONLINE_IDLE,
> > +	CPUHP_AP_HYPERV_ONLINE,
>=20
> x86 maintainers, are you okay with this?
>=20

Boris -- Are you OK with this, and could give an ACK?  This small patch
set fixes a problem introduced into 6.4-rc1 by other Confidential VM
changes, so this fix needs to be incorporated before 6.4 is released.

Michael

> >  	CPUHP_AP_KVM_ONLINE,
> >  	CPUHP_AP_SCHED_WAIT_EMPTY,
> >  	CPUHP_AP_SMPBOOT_THREADS,
> > --
> > 1.8.3.1
> >
