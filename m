Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22959D009
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Aug 2022 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiHWE1K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Aug 2022 00:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiHWE1J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Aug 2022 00:27:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF3F3CBD2;
        Mon, 22 Aug 2022 21:27:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x19so9557682pfq.1;
        Mon, 22 Aug 2022 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=8O32nIU+E94T4lj/ioNF6HtVBi6nRMpp7pamJorcVy8=;
        b=f/dGN8vBO8yvLWXhlmnB2tMhLft+P997o8doz3LRo7SxoJMJRu20XJAU2fNQTKg1tZ
         K36dTB9LIOgqRtkYe8RkyubzJkqcu+e7f2um2vi+UNlqVVYC18vpN+cZqfcPH/MNaxD7
         l3bHz3IJTYU5DkoxA9iPqjrjm+nGtdZ2QzR3i9mgmbIYA6TFYhdGkGAPNSYk8+2PSOtN
         lozYkPmIIc7scMQV6lywikln95Wh6smZBgAWLxispAniUSGE4jNrEtHZjPjBEEiTpe/g
         48uxpQ+sIP05F+5JHvWTBJCZsdZvLzGIaZCfTXT7UeZ74DqiC8q7hRWIOtq0A+rhkoa/
         ATzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8O32nIU+E94T4lj/ioNF6HtVBi6nRMpp7pamJorcVy8=;
        b=Xe6wooe9glXxrPOOmpGBhsjViY2tXx6bl9OfYGpYmH07gZ2u2A1l1fV87u8MBQgddU
         szSc0vKSZdYUy/F52IT17Fef1KgZbru1vSyMXNbfXIHrBsk9j7OS/di6VsRsjzabZGJO
         LGD1vyyjTgY0U0Z8dGYfZVTQl9wmrd7pGPoPoTIpjGoF2VSjcb1JeS/KUjV7DrUeNOfG
         7trfMZ6kcT0hVtnRqddZ+tgCkbllgqYZsS54e0lfjQG0CqWeArmBSyca0/q1GLDW0CSx
         /Ldzl11Oppip7sGd9tGrh/1M9wzS3Wg9tvk6dDl85KadTqxYOQNQA5Ag/l2aIJ87Zv16
         ETVQ==
X-Gm-Message-State: ACgBeo19+yo8bkrJOh97vO0ruFerHiX64GRgaI29k1P+QfVc86Z5QC0E
        6H6KEVIUsyjEsBOWdR0Gb48=
X-Google-Smtp-Source: AA6agR7G0/OogiCOKP4W9o8q31gLZFkujaXjy0F/tTrRNtWGMP5nbcz5gKHlv9jri/Bt6+sf4pqLXg==
X-Received: by 2002:a63:6804:0:b0:422:1689:ed05 with SMTP id d4-20020a636804000000b004221689ed05mr18887367pgc.289.1661228826515;
        Mon, 22 Aug 2022 21:27:06 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ebe5:ba37:26e1:8072])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm9108397plt.297.2022.08.22.21.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 21:27:05 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:27:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] Input: move from strlcpy with unused retval to strscpy
Message-ID: <YwRXFsEyc39lbPQX@google.com>
References: <20220818210022.6865-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818210022.6865-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 18, 2022 at 11:00:19PM +0200, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied, thank you.

-- 
Dmitry
