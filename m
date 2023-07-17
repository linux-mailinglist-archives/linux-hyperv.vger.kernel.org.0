Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1807560C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jul 2023 12:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGQKoZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jul 2023 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGQKoY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jul 2023 06:44:24 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD411F;
        Mon, 17 Jul 2023 03:44:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 923485C00F4;
        Mon, 17 Jul 2023 06:44:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Jul 2023 06:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689590662; x=1689677062; bh=S0
        E2ik2Q5WYq90hY6DPf5ttlL5ZI3LD8t/OSQKEdXvg=; b=TQJqH1SA0SqMkDSkPK
        /k/fILhxOKxIjgcVIvR78ejZ7deNC009+kGS3/gtHkocV+RIRphWLN2KP6nzw78t
        8wtpI1pcFa35H95KEVb8Whm2WyGOANF5bssAO+HLanfIhE0IDP+k4Tn5OPsDPiMF
        Zwv47RUSSVw1H+QKc2CYR9/zTGWKaC6T+wxyXUpjJDsD7IOlARSbKDUSLQW2/Q7f
        x6oRHiWGDbrGujVr11wYcEBuipnOg2EHeFU/HR/iO2FNWYZ2QiHOdjKb/JMSkkcq
        7YlBBpzdGO8oFeCvtMdJU24DvLmVkjlbnqYQQGPUMx7GrUNUU39L2nDBsvlLCGCT
        vx8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689590662; x=1689677062; bh=S0E2ik2Q5WYq9
        0hY6DPf5ttlL5ZI3LD8t/OSQKEdXvg=; b=RYvk0kmE/jJKooZK/9/MD/wu196Tg
        nmvdXAumSbguMpaFVq+sEWW/Cwx0wStb2MVWJpjGbIaZd2QiAyoTAIRjYngGgl2Q
        ozFGBdsVr7dugcszUu9zxxL2GZwO1lhJye8hSKOLVVqb8iOFXspSC+7KisFMFd3j
        ctvEaSV3RV1jHlEc0OMjxKKbrU/ueHz0WBUiGA1Ql6D/1xiTQH6BX4/FSG8LsyiM
        rj2om6Qj+ziWCwOgRYSk6gRSOgtSdmBsB8mMiwDGij/vzG3DwNe33HjS2FQoJTbD
        4mdyJlJ9545fQlXKGW0/FtLmCyEM6VPq5dl1ZIdi01DqKVT0YPMJHi9wQ==
X-ME-Sender: <xms:hRu1ZCcw_JOKkCwUkLh7K5cQ5Y7k4AenwS_tSgnBVo0rjqFBui8PMw>
    <xme:hRu1ZMOmjRN5qJqaiTnbzFaLIPCB-8lfpKOByHMkRZsn9A5GiEC9Asdov5z9WHUCS
    IVcS6V3F6PFB9qhE4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hRu1ZDiLR2RVDesxnOWl8HQqxxzNBFQwWJOgqXZl8yPsI0n2kb2vaA>
    <xmx:hRu1ZP8CDiaR9ZZ-0XrDhSbnqNECOu1cAgcw1noVHQkz-ebPQ5Ah4A>
    <xmx:hRu1ZOskAOxlfrMKuxIseLUHreyzJmRVL9b97Q0pXhSzEd4DJNEBNw>
    <xmx:hhu1ZDPtcM9pLWbfQKyxJNy7TCqXdhWTSAdcqph1wae2PvYKzLjo9g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B15DB60086; Mon, 17 Jul 2023 06:44:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <b0f2c4d3-c5d6-4887-b2c1-2d464c918775@app.fastmail.com>
In-Reply-To: <ZLULjoePQaF+nSk2@smile.fi.intel.com>
References: <20230705140242.844167-1-arnd@kernel.org>
 <ZLULjoePQaF+nSk2@smile.fi.intel.com>
Date:   Mon, 17 Jul 2023 12:44:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>,
        "Paulo Miguel Almeida" <paulo.miguel.almeida.rodenas@gmail.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "Dawei Li" <set_pte_at@outlook.com>,
        "Yang Yingliang" <yangyingliang@huawei.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hyperv: avoid struct memcpy overrun warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 17, 2023, at 11:36, Andy Shevchenko wrote:
> On Wed, Jul 05, 2023 at 04:02:24PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> A previous patch addressed the fortified memcpy warning for most
>> builds, but I still see this one with gcc-9:
>
> JFYI: as of today I have run Linux Next with `make W=1 allmodconfig` on x86_64
> and it seems there are still tons of similar issues which break the build.

It's a bit more complex:

- yes, there are lots of warnings for memcpy() read overflow when you
  build allmodconfig kernels with W=1. I have patches for all of these and
  plan to submit them over time.

- This particular one is a memcpy /write/ overflow, i.e. the
  destination type overflows with the length according to gcc's
  understanding of the structures. This warning is enabled even
  without W=1, though it may only show up in certain configurations
  or compiler versions.

      Arnd
