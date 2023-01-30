Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB5768154F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjA3Pm3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 10:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbjA3PmW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 10:42:22 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EFC402E1;
        Mon, 30 Jan 2023 07:42:12 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id h12so11468214wrv.10;
        Mon, 30 Jan 2023 07:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUbT8GW2Xe7TYWK+SBC453IgVa+1sYQmDI5rwmFeFNw=;
        b=deFG83Bl4pilxPW8MXRiHJO2NlKic2n5EmXOAm7IkCSQqU6HqdUcbaymqgXzr+5JYv
         PrbbAeaNOTE8l87rzxQlHET8Cg1xci7xV1WDt+gDduQEL/p4LKI1h79bYLPT5TYSKJeM
         FDCGVKq61iZ5q23IGaaUYDW4nMdyQw8E0crkSurMus7lHFLdoEjf8MH1aA/F8eywkIEW
         eqyCckFc2mK39n9aUnLzll2tJlyrJ59FwJfSpEetovXD7KWHY505LPG3n+eyeoU6hgZf
         KOdozAVGhY947CXbYsCl6L2NHdJaCXFdFQvPC2rGy4m76uL9AmLbAImxQxWKCwnsVEBL
         sf6w==
X-Gm-Message-State: AO0yUKVpUCL/xjNWens7EvNVhmbyrmslom1QbBCMVsjT2OWpk+Cyp/6Z
        xGqt817KPzJS6Hku4jdq0UQ=
X-Google-Smtp-Source: AK7set9bilzV+cycilUvhPXZZQ4RW9LvqXB3OMkaS0/xxipVSHC82hgRy+Gvk8bq1qBYOdHHuQZcdA==
X-Received: by 2002:a05:6000:609:b0:2bf:d14a:21dd with SMTP id bn9-20020a056000060900b002bfd14a21ddmr16045718wrb.29.1675093331155;
        Mon, 30 Jan 2023 07:42:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b002be53aa2260sm13482929wrs.117.2023.01.30.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:42:10 -0800 (PST)
Date:   Mon, 30 Jan 2023 15:42:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/9] HID: hyperv: Constify lowlevel HID driver
Message-ID: <Y9flUYVZBWXwdZfk@liuwe-devbox-debian-v2>
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
 <20230130-hid-const-ll-driver-v1-2-3fc282b3b1d0@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130-hid-const-ll-driver-v1-2-3fc282b3b1d0@weissschuh.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 30, 2023 at 03:59:38AM +0000, Thomas Weiﬂschuh wrote:
> Since commit 52d225346904 ("HID: Make lowlevel driver structs const")
> the lowlevel HID drivers are only exposed as const.
> 
> Take advantage of this to constify the underlying structure, too.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Wei Liu <wei.liu@kernel.org>
