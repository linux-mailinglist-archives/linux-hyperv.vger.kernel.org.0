Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809036281B4
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Nov 2022 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNNyd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Nov 2022 08:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiKNNyb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Nov 2022 08:54:31 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA87025E80;
        Mon, 14 Nov 2022 05:54:30 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id a14so18398700wru.5;
        Mon, 14 Nov 2022 05:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oFMvSA5F3rppofI7SoRzagW0D4LaF+9vjlIOciAVY8=;
        b=gpAJWYQqeUzkQTIdW4X42hrpy2Q90rBzYAMYezKVrgr8siLEHaktmxF7zJtzjAYjTu
         Bqz5nNCP8sX3zCJbFS0/Z6/0QecGzDZ1v5XG8PdtadZLGBEpIBMNz4LzG0GZb5KScGrf
         WDnm40XnUFUea+W1b8JY7XTv9w1GwcmCnuAcXPw1RwdKNS+v9h3seZ8nrPi3qCb48aKm
         kUXx+9kFJBIDQf5V8AxbYqNRw/9h3dg4cZPPMHym8uuVzGGdnJoGfDzYJVcdal+Rufa3
         fDF4GMl2kuXhO4JSKaPTve5f8aeNZLl8eKpYghe0nuIlTrndetwvxNwIF+fyyvwPnghS
         TzTA==
X-Gm-Message-State: ANoB5pnQwD1fex6zRMD+1HED0Cw6khXWgfOpoAs++G3rzfd8VvFEdsqk
        f+Ux+5kh/MMCpLvv1uyTF6vTA41OrHg=
X-Google-Smtp-Source: AA0mqf79hxWHWGJbp01fRfL4A1rRQTw0WZ85IsYsg9hD4BtF8KQ7Pn3B9/pr9qzVomcilIHK18S3WA==
X-Received: by 2002:a5d:43d0:0:b0:236:4e3c:7720 with SMTP id v16-20020a5d43d0000000b002364e3c7720mr7675775wrr.674.1668434069451;
        Mon, 14 Nov 2022 05:54:29 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d54cb000000b002415dd45320sm9615277wrv.112.2022.11.14.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:54:28 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:54:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dexuan Cui <decui@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        x86@kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v3 0/4] hyper-v: Introduce TSC page for root partition
Message-ID: <Y3JIk6sW9lZ6UvC7@liuwe-devbox-debian-v2>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 03, 2022 at 05:58:43PM +0000, Stanislav Kinsburskii wrote:
> 
> Stanislav Kinsburskiy (4):
>       drivers/clocksource/hyper-v: Introduce a pointer to TSC page
>       drivers/clocksource/hyper-v: Introduce TSC PFN getter
>       drivers/clocksource/hyper-v: Use TSC PFN getter to map vvar page
>       drivers/clocksource/hyper-v: Add TSC page support for root partition

Applied to hyeprv-next. Thanks.
