Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3091353441F
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 May 2022 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbiEYTQ4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 May 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbiEYTPW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 May 2022 15:15:22 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A121C43
        for <linux-hyperv@vger.kernel.org>; Wed, 25 May 2022 12:15:15 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id n135so10332331vkn.7
        for <linux-hyperv@vger.kernel.org>; Wed, 25 May 2022 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=VNL84agSPUNMz5ZHn5hB8GKcuYXWF3UmMPWc7Bb+LTV1k24f+olrtYnNlECI/5grU/
         gJfb9UnvXZhJDQqxsv/dzXgW1bjbq6IyojfmDsYouIZcF/WLojUh+pm2fw627QIhk2g/
         McEXiBrW7myNWu/lTrZvV8JW18fcv6SsDZ/36tX/pTSJWvCIFih0lZxPpUgHRWNLrUle
         p51+K/qbZ2PDQN0m49bSNWKknBDBPc4o0UNjJrkblUW7AxjIR7wXBWHyN8I3iTp4HVMq
         y0q/tTDGDPnjhRXcTELUkXzKa/fVcyoZ9W4DIAPSTdDiTGXbXBGKFL0k9dTRI7X3nIhl
         +vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=FAaUmYPXjmHty+/jfZ9vYOdUrSIRjGR75OL3KqVgkqpqhekbYK8taigmRK0eCoNCQT
         wpq+Qj0tC0p+Xlc6pViQSQzbK9pBNBIEFbJkwOVywRrrKKrC8qTaKXpf20SDSI8XTSJG
         KLov6cB9D0xn615E0x8KIreIxAuiSAoTYXwdP9tnT0cIhdFc301Lpp8wHb4ij/G2IEJK
         FwWupvJnH7O+eL6gZOxstgptr50YCd2AmJvYsHfneN9DgkB36ZWugnfI7RZuGD0Q7OiZ
         8tQIjPD7YSMaSwQiZUAldHnqAoN+LN46yD6m8YOztGNR0iMJ1nAfXwGpoVKKAs5+8b45
         iqXQ==
X-Gm-Message-State: AOAM533nPFebAQv68t2N+aU+JzgeNGE4U06i16DcuGIW/1irBcrz2F2S
        t6zF6aW/EE2Vstp0M4jQIAnZA7oQGbK16OpkKIw=
X-Google-Smtp-Source: ABdhPJxvbXspaz4zW4ghROwe7mtZm5WXla6DcckQd/HYDwGnn3YvHT4Qg0k+dKQaME7SWYaZN0WbIPCLHXqJnnpri0k=
X-Received: by 2002:a05:6122:2228:b0:32d:e4e:a79a with SMTP id
 bb40-20020a056122222800b0032d0e4ea79amr12275696vkb.27.1653506113167; Wed, 25
 May 2022 12:15:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d484:0:b0:2bc:cae4:6d22 with HTTP; Wed, 25 May 2022
 12:15:12 -0700 (PDT)
From:   Rolf Benra <olfbenra@gmail.com>
Date:   Wed, 25 May 2022 21:15:12 +0200
Message-ID: <CA+z==VuwuBBVBk+=-U0t779uO36bFwSsYR6Qwgz2z9Wbkk3iGw@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Rolf Benra

olfbenra@gmail.com







----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Rolf Benra

olfbenra@gmail.com
